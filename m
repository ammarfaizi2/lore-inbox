Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWBRXfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWBRXfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWBRXfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:35:19 -0500
Received: from 69-172-25-214.clvdoh.adelphia.net ([69.172.25.214]:8675 "EHLO
	ever.mine.nu") by vger.kernel.org with ESMTP id S932286AbWBRXfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:35:19 -0500
Date: Sat, 18 Feb 2006 18:35:15 -0500
Message-Id: <200602182335.k1INZFoi012487@rhodes.mine.nu>
To: petero2@telia.com
CC: linux-kernel@vger.kernel.org
From: linuxer@ever.mine.nu
In-reply-to: <m3r760cntz.fsf@telia.com> (message from Peter Osterlund on 18
	Feb 2006 23:19:04 +0100)
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu> <m3r760cntz.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Osterlund <petero2@telia.com> writes:
  > 
  > linuxer@ever.mine.nu writes:
  > 
  > > In drivers/block/pktcdvd.c it appears that in the case of DVD
  > > rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
  > > (the maximum writing speed reported by the drive). 
  > > 
  > > In my case, I have a new drive capable of 8x re-writing. However, all of
  > > my existing media is rated for only 4x rewrite speed. 
  > > 
  > > When attempting to rw mount these disks, pktcdvd reports:
  > > 
  > > Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
  > > Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
  > > sense 00.54.9c (No sense)
  > > Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
  > > 
  > > And then of course a huge heap of I/O errors on the disk. 
  > 
  > Have you verified that this is caused by the speed setting, ie does it
  > work correctly if you hack the driver to write at 4x speed?
  > 

Correct. Adding a hard-coded manual setting of write_speed = 5540 to
pkt_open_write results in functional operation (at least with 4x rated
DVD+RW media).

Obviously, this particular drive is perfectly happy to try to write at over
the rated media speed if it is asked to. I can't fault the manufacturer for
this, for I generally like the idea of letting the user decide instead of
imposing hardware/firmware fixed limits. 
