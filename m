Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbTDOX5D (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbTDOX5D 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:57:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264166AbTDOX5C 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:57:02 -0400
Date: Tue, 15 Apr 2003 17:07:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-Id: <20030415170748.1c9f0e1c.rddunlap@osdl.org>
In-Reply-To: <3E9C9B19.7000107@myrealbox.com>
References: <fa.hdvi4hc.152sj34@ifi.uio.no>
	<fa.fnhqqrs.ok0028@ifi.uio.no>
	<3E9C9B19.7000107@myrealbox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 16:51:53 -0700 walt <wa1ter@myrealbox.com> wrote:

| walt wrote:
| > Patrick Mansfield wrote:
| > 
| >> On Sun, Apr 13, 2003 at 07:44:04PM +0200, Gert Vervoort wrote:
| >>
| >> Here is a patch against 2.5.67, can you try it out?
| >>
| >> I did not compile let alone run with this patch.
| >>
| >> We never hold the host_lock while calling the detect function (unlike the
| >> io_request_lock, see the bizzare 2.4 code), so acquiring it inside
| >> ppa_detect is very wrong. I don't know why your scsi scan did not hang.
| >>
...
| > 
| > 
| > 
| > Yes!  Thank you.  This patch fixes the segfault of modprobe that I've 
| > been seeing for ages.
| 
| Hmm.  An important addendum --
| 
| I can mount and unmount the Zip disk as many times as I want, as long as
| I don't eject the disk from the drive.
| 
| Once I eject the disk and insert it again, the mount commant just hangs
| forever.  No error messages anywhere -- it just hangs.  I can't even
| kill the mount command.  The only way out is to reboot and then all is
| well again until the next time I eject the disk from the drive.


I don't know that it's _required_, but you can try doing
  umount /mnt/zip              (or /dev/sdx)
  eject /mnt/zip               (or dev/sdx)

and then eject it, reinsert it, try to mount, etc.?

--
~Randy
