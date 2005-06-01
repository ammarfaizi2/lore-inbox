Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFAWd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFAWd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFAWdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:33:10 -0400
Received: from alog0111.analogic.com ([208.224.220.126]:11750 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261347AbVFAWcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:32:10 -0400
Date: Wed, 1 Jun 2005 18:31:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: How to replace an executing file on an embedded system?
Message-ID: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The newer linux kernels have this problem:

Suppose I do this:

cp /sbin/init foo	# Make a copy of 'init'
mv foo /sbin/init	# Rename it back (emulate install)
chmod +x /sbin/init	# Make sure we can boot.

When I try to umount() the file-system, it now fails with
EBUSY (16).

I have tried fsync(), sync(), fsync() on /sbin, etc. I can't
get rid of the busy inodes.

This reared its ugly head with field software upgrades. We
used to be able to upload new software for every executable
on an embedded system using the network or a serial link.

This would replace every file. We would then kill all the
tasks except 'init', unmount the file-system and then reboot.
The upgrade was finished. Every lived happily ever after.
But, with newer kernels, we can't.

What am I missing?  How am I supposed to replace files that
are being executed? Do I have to `mv` them to /tmp and
delete them on the next boot? (not easy, we don't have
a shell, I would have to write code to search /tmp). Also
'init' isn't SYS-V 'init'. It's just the startup program
for a system that keeps growing so I need to be able to
upgrade it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
