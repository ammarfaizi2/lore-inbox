Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbTGMNvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267912AbTGMNvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:51:48 -0400
Received: from h004005b9b492.ne.client2.attbi.com ([24.60.209.71]:60843 "EHLO
	joehill.bostoncoop.net") by vger.kernel.org with ESMTP
	id S267861AbTGMNvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:51:44 -0400
Date: Sun, 13 Jul 2003 10:06:28 -0400
From: Adam Kessel <adam@bostoncoop.net>
To: linux-kernel@vger.kernel.org
Subject: DVD/CD Read Problem: cdrom_decode_status: status=0x51 {DriveReady SeekComplete Error}
Message-ID: <20030713140627.GA761@joehill.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors and an unkillable process when trying to play
DVDs, using the latest 2.5.75: 

Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: error=0x30LastFailedSense 0x03 

and sometimes: 

Jul 13 00:15:03 joehill kernel: hdc: ide_intr: huh? expected NULL handler on exit 

This problem has been discussed several times before on this list[1], but with
no resolution or fixes that I can find.  

I don't believe this is a userspace issue.  Other OS's are able to deal with
playing video DVDs by skipping read errors quickly.  There should be some one
way to tell the kernel not to keep retrying for certain (i.e., non-data)
CD/DVDs.  I can't see any possible way to do this in application space, though.  

I've tried building the kernel with CONFIG_IDEDISK_MULTI_MODE as per some
suggestions on this list. This may have made a small difference, although it
might have also just been a lucky run.  

I also tried setting ERROR_MAX and ERROR_RESET to 0 in ide-cd.c, which did
shorten the "hanging" duration, but didn't fix it entirely, and also seems like
a bad way to fix this problem.  

I'm not sure why it's getting errors at all, incidentally, as this occurs
with brand new DVDs out of the shrink wrap, and a relatively new DVD
player (HP F2015B, manufactured by Quanta).  

--Adam Kessel

[1] Most recently in April of this year:

"Bug in linux kernel when playing DVDs."
http://www.ussg.iu.edu/hypermail/linux/kernel/0304.3/0769.html

And in March:

"Help please: DVD ROM read difficulty"
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.0/1570.html
