Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSGNIOA>; Sun, 14 Jul 2002 04:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGNIN7>; Sun, 14 Jul 2002 04:13:59 -0400
Received: from ppp1217-cwdsl.fr.cw.net ([62.210.116.194]:40210 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S314529AbSGNIN6>; Sun, 14 Jul 2002 04:13:58 -0400
Message-ID: <3D313412.1030102@paulbristow.net>
Date: Sun, 14 Jul 2002 10:19:30 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl> <3D2EE7BA.8080805@evision-ventures.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Dalecki wrote:

>Workarouns in ide-floppy - ZIP drives and Clock drives.
>
>Those are the main "technical issues" which make one hessitate.
>  
>
Sorry, late to this thread.  Look, ide-floppy has to deal with real 
world devices, which simply don't follow nice, written specifications. 
 If we treat these devices as standard ATAPI they simply don't work.

And a bunch of planned features which were waiting for 2.5 but are now 
in limbo until the IDE subsystem is stable enough for me to work on.  

Features include:

Trying again to kill the via chipset/Zip interaction (some people are 
still suffering).

Kevin Flemings media detect work: needs ATA commands because the ATAPI 
command set simply doesn't return the information we need.  Then we can 
make ide-floppy drives work *properly* with devfs.

Handling the "special" BIOS settings around LS-120/240/Zip bootable 
drives.  

Making sure that formatting works properly for non-standard format 
capacities (i.e. 1.44MB in LS-120, 32MB in LS-240)

And yes, I have real users asking for these things.

So to me the problem is not to make everything work as SCSI, because 
that simply isn't true for ide-floppy devices.  They *nearly* work, so 
you can get kludgy, "good enough for command line gurus" working with 
ide-scsi, but there are some funnies.  Does it really make sense to have 
IDE/ATAPI kludges down in the SCSI tree?

I much prefer Linus's suggestion of agreeing on the top level API.  I 
would like to see disks, and removeable media having a single unified 
namespace and set of ioctls so that the different user-space programs 
don't need to worry about if they are dealing with a SCSI, PPA, 
ATAPI-ish, USB, 1394 or whatever comes next drive.  Is that work? yes, 
but it's also about communication and keeping things in the appropriate 
place.  Let me hide the horrible things ide-floppy has to do from 
user-space, and if that means I/we have to completely re-write the 
ioctls etc so be it.  

-- 

Paul

/* ide-floppy maintainer */

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223



