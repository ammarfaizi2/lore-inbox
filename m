Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRARLgT>; Thu, 18 Jan 2001 06:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbRARLgK>; Thu, 18 Jan 2001 06:36:10 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:4872 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S130113AbRARLf7>; Thu, 18 Jan 2001 06:35:59 -0500
Date: Thu, 18 Jan 2001 11:35:57 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: David Balazic <david.balazic@uni-mb.si>
cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <3A66CD09.F0111CB5@uni-mb.si>
Message-ID: <Pine.LNX.4.30.0101181130590.23287-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How does MD/RAID0 know which array should be /dev/md0? What if you had a
> > > second array on /dev/hdb and /dev/hdd, would that become /dev/md0 (assuming
> > > it had a kernel/boot sector)?
> >
> > /etc/raidtab specifies which drives belong in which array, but I only have
> >  hda and hdc so I can't really answer the question
>
> What happens if /dev/md0 is /dev/sda and /dev/sdc ( the system also has
> sdb )
> and sda fails or is removed ?
> the old sdb will now be sda and old-sdc will be sdb.
> md0 will look into sda , which is now the non-md disk , and
> sdc , which doesn't exists any more ???

This is when devfs comes into its own, as the disks are refered to by
their device/controller id not by the /dev/sd{a,b,c,etc} numbering, hence
when one fails the others don't change. Also I think the kernel autodetect
code for scsi devices will deal with this case, but I'm not sure.

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

Catapultam habeo. Nisi pecuniam omnem mihi dabis, ad caput tuum saxum
immane mittam (For non-latiners: "I have a catapult. Give me all the
money, or I will fling an enormous rock at your head.")

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
