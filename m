Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVCVANd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVCVANd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVCVAN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:13:28 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:44997 "EHLO
	smtp.handelsweg8.nl") by vger.kernel.org with ESMTP id S262242AbVCVAMc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:12:32 -0500
Date: Tue, 22 Mar 2005 00:12:06 +0000
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: 2.6.11: iostat values broken ?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <d053g8$6et$1@news.cistron.nl>
	<20050321140942.344fff89.akpm@osdl.org>
In-Reply-To: <20050321140942.344fff89.akpm@osdl.org> (from akpm@osdl.org on
	Mon Mar 21 23:09:42 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111450326l.31909l.8l@stargazer.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 23:09:42, Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > I just upgrades one of our newsservers from 2.6.9 to 2.6.11. I
> > use "iostat -k -x 2" to see live how busy the disks are. But
> > I don't believe that Linux optimizes things so much that a disk
> > can be 1849.55% busy :)
> > 
> > (you'll have to stretch out your xterm to be able to read this):
> > 
> > Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
> > hda          0.00  50.00  0.00 18.18    0.00  545.45     0.00   272.73    30.00     2.35  129.00  86.25 156.82
> > hdc          0.00  45.45 77.27 31.82 3927.27  618.18  1963.64   309.09    41.67     6.27   57.42  38.42 419.09
> > hdd          4.55   0.00 63.64  0.00   68.18    0.00    34.09     0.00     1.07     1.11   17.43  17.43 110.91
> > hde        477.27   0.00 45.45  0.00  522.73    0.00   261.36     0.00    11.50     0.40    8.90   8.90  40.45
> > hdg         18.18 70154.55 22.73 172.73   40.91 70727.27    20.45 35363.64   362.07  1010.36 1127.72  94.63 1849.55
> > 
> > With 2.6.9, %util never came above 100% (and that was indeed "fully loaded".
> > I have systems with a comparable load running 2.6.10 and 2.6.11-rc3-bk4
> > that also don't show this behaviour (but those are SCSI, not IDE).
> > 
> > I use CFQ, but changing that to deadline doesn't make a difference.
> > 
> 
> Mike, did you ever get to the bottom of this?  Still happening in 2.6.12-rc1?

Sortof... (I already posted this before:) the siimage.c driver was broken for me with
2.6.11. Lots of IDE warning messages to /dev/console @ 9600 baud also makes
things slow and weird. I couldn't find what caused this, though, there
weren't much (if any) changes in siimage.c so it must have been something
different. Perhaps the IRQ changes.

I moved to sata_sil.c and everything now works fine. I tried sata_sil around 2.6.5
or so, and it was very unstable, but I was pleasantly surprised to see that
the new SATA code has come a long way.

So I still don't know what the _actual_ problem was, but the solution is
"use libata instead of the old IDE driver". As "make menuconfig" tells you
something similar it's probably an acceptable solution.

Mike.

