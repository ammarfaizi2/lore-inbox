Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTKKQbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTKKQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:31:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26118 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264351AbTKKQbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:31:42 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: IDE disk information changed from 2.4 to 2.6
Date: 11 Nov 2003 16:21:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bor29j$c2d$1@gatekeeper.tmr.com>
References: <20031105172310.GE5304@conectiva.com.br> <20031111114649.GA16163@win.tue.nl>
X-Trace: gatekeeper.tmr.com 1068567667 12365 192.168.12.62 (11 Nov 2003 16:21:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031111114649.GA16163@win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
| On Wed, Nov 05, 2003 at 03:23:10PM -0200, Flavio Bruno Leitner wrote:
| 
| > Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware 
| > changed. This behaviour is correct? 
| > 
| > Using 2.4:
| > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)
| > 
| > Using 2.6:
| > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)
| 
| Yes, correct in the sense that it is not wrong.

  I'll remember that phrase, interesting way to put it.

| Probably your disk reports 15 and 2.4 invented 255.

Almost looks as if the BIOS is using the faked values to keep the
cylinders < 1024 to make the old BIOS calls work, and the 2.6 init is
looking at the real geometry of the device (in the sense of "what the
device itself reports, of course).
| 
| CHS is something that stopped being meaningful a decade ago.

Unfortunately while this is true at the kernel level, applications do
use it. The ones of interest to most people are parted (as noted) and
fdisk. Changing the values will make them whine, and may actually cause
malfunction.

| Today it is random garbage, to be ignored whenever possible.
| Don't worry about CHS when you don't have problems.

In general the BIOS should be told to report drive size in
non-translated values, using LBA or LARGE or similar options depending
on the BIOS. I suspect this was not done prior to the initial install.
And if this machine dual boots you really don't want to change it now!

The CHS can be set on the boot line. I haven't used this in years, so I
have no idea if that still works or even exists. 

You can also go into the expert menu of fdisk and change the values
used there. Another thing I haven't done in ages, but the commands to
do so are still present. This mainly allows you to avoid "partition
does not start on a track boundary" warnings.

As you note, most of this is better not used, but it might have been
better to try the boot time setting of CHS before using parted, just to
avoid possible problems, *but I certainly wouldn't do that now*.

It seems parted doesn't handle Win/XP partitions, which is too bad,
since adding Linux to commercial laptops was the most frequent use I
made of it. Perhaps there's a newer version, I haven't looked in some
months.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
