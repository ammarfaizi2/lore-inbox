Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFAXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFAXnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFAXnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:43:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:23472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261490AbVFAXmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:42:07 -0400
Date: Wed, 1 Jun 2005 16:42:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to replace an executing file on an embedded system?
Message-ID: <20050601164203.2729520b@dxpl.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>
References: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005 18:31:07 -0400 (EDT)
"Richard B. Johnson" <linux-os@analogic.com> wrote:

> 
> The newer linux kernels have this problem:
> 
> Suppose I do this:
> 
> cp /sbin/init foo	# Make a copy of 'init'
> mv foo /sbin/init	# Rename it back (emulate install)
> chmod +x /sbin/init	# Make sure we can boot.
> 
> When I try to umount() the file-system, it now fails with
> EBUSY (16).
> 
> I have tried fsync(), sync(), fsync() on /sbin, etc. I can't
> get rid of the busy inodes.
> 
> This reared its ugly head with field software upgrades. We
> used to be able to upload new software for every executable
> on an embedded system using the network or a serial link.
> 
> This would replace every file. We would then kill all the
> tasks except 'init', unmount the file-system and then reboot.
> The upgrade was finished. Every lived happily ever after.
> But, with newer kernels, we can't.
> 
> What am I missing?  How am I supposed to replace files that
> are being executed? Do I have to `mv` them to /tmp and
> delete them on the next boot? (not easy, we don't have
> a shell, I would have to write code to search /tmp). Also
> 'init' isn't SYS-V 'init'. It's just the startup program
> for a system that keeps growing so I need to be able to
> upgrade it.

The image of the file being executed has to exist because
the text portion could be needed at any time for a page in.

You can move it in the same filesystem (since the open file handle 
stays the same), or even delete it (since it doesn't disappear till
last reference goes away). but you can't unmount the file system because
the inode is still busy.


