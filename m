Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318327AbSICO33>; Tue, 3 Sep 2002 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSICO32>; Tue, 3 Sep 2002 10:29:28 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:35592 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S318327AbSICO32>; Tue, 3 Sep 2002 10:29:28 -0400
Date: Tue, 3 Sep 2002 09:34:00 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: mbs <mbs@mc.com>
cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <200209031237.IAA27024@mc.com>
Message-ID: <Pine.LNX.4.44.0209030917040.17540-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, mbs wrote:

> it trashed mine also.
> 
> supermicro p4dp8-g2 mobo
> 2x 2.2 Xeon
> e7500 chipset
> wd400 40gb hd
> 
> 2.4.20-pre4-ac2 + RML preempt patch (applied cleanly)
> 
> boot it and eveything runs fine for a short while, then I start getting "bad 
> CRC" errors and "seek failure" errors.
> 
> I have had this problem with both ext2 and ext3
> 
> initially I thought it was a bad HD, so I installed a new one on a new cable 
> and did a complete rh7.3 install ran for a while eith no problems then built 
> the same kernel over again, rebooted into the new kernel and within seconds 
> was having problems again.
> 
> 2.4.19-rc3-ac4 +rml preempt has been dead stable, as has (so far) 2.4.29-ac4 
> +rml and RH 2.4.18-3 and -5
> 
> I am not doing anything funky with hd setup, not even specifying idebus= 
> 

This is likely different than the problem I've been seeing.

My situation appears to be due to the fact that on my Promise
controller, LBA48 addressing mode had been turned off on the primary
channel, which then causes access problems with my 160GB Maxtor drive.  
Turning LBA48 mode back on (by removing the hack which turned it off,
which wasn't in 2.4.19-ac4) breaks DMA.  Either that or I screwed
something up when removing the hack.  I'm wondering if a bug appeared
after 2.4.19-ac4 which breaks DMA on Promise 20265 primary channel
access, and that a work-around was put in place that disables LBA48
addressing.  There are in fact well over 100 diffs in pdc202xx.c between
2.4.19-ac4 and 2.4.20-pre4-ac1.  This wrong addressing is what
(indirectly) wrecked my system.  I've posted my findings on this so far
along with some questions for further investigation, but I haven't seen
any answers yet (or even a "go away you're bothering me" reply).

Unfortunately you've said you are using a 40GB drive and something other
than a Promise controller so your situation may be a different problem.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

