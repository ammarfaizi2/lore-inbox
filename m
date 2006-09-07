Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWIGQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWIGQVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIGQVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:21:36 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:11863 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932261AbWIGQVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:21:34 -0400
Message-ID: <45004707.4030703@tls.msk.ru>
Date: Thu, 07 Sep 2006 20:21:27 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: re-reading the partition table on a "busy" drive
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kernel refuses to re-read partition table
from a drive which has usage count > 0.  Motivation for
this is pretty clear (to not mess up with already open
devices/partitions/filesystems, if I got it right ;),
but this also is pretty annoying -- in order to change
unrelated, yet unused partitions on root drive, one has
to reboot the machine.

I wonder if it's possible to actually read the new partition
table, compare it with previous, and apply changes IF they
don't conflict with currently open partitions?  Say, if we
have sda1 and sda2, sda1 is open/mounted, and new partition
table does not have sda2, but sda1 is unchanged - it's pretty
safe to apply new partition table, without affecting mounted
sda1.  Ditto for adding new partitions.

Yes, a line should be drawn somewhere - say, if sda3 was
mounted, and we removed unused sda2, but sda3 (which becomes
sda2 with new table) is intact, we should not apply new
table.

Is it possible to implement such a feature?  I mean, is it
easy to know which *partitions* (subdevices?) of the whole
device are currently in use, as opposed to the whole drive?

Thanks.

/mjt
