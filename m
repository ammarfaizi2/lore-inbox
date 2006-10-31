Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946018AbWJaVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946018AbWJaVWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946019AbWJaVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:22:06 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55464 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946018AbWJaVWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:22:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 22:20:46 +0100
User-Agent: KMail/1.9.1
Cc: Luca Tettamanti <kronos.it@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
References: <20061031174006.GA31555@dreamland.darkstar.lan> <20061031200407.GA5194@dreamland.darkstar.lan> <4547AED6.1020909@comcast.net>
In-Reply-To: <4547AED6.1020909@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312220.48354.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 31 October 2006 21:15, John Richard Moser wrote:
> 
> Luca Tettamanti wrote:
> > Il Tue, Oct 31, 2006 at 02:41:11PM -0500, John Richard Moser ha scritto:
> >> Rafael J. Wysocki wrote:
> >>> On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
> >>>> On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> >>>>> Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> >>>>>> On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> >>>>>> [snip]
> >>>>>>
> >>>>>>> However, we already have code that allows us to use swap files for the
> >>>>>>> suspend and turning a regular file into a swap file is as easy as
> >>>>>>> running 'mkswap' and 'swapon' on it.
> >>>>>> How is this feature enabled? I don't see it in 2.6.19-rc4.
> >>>>> Swap files have been supported for ages. suspend-to-swapfile is very
> >>>>> new, you need a -mm kernel and userspace suspend from CVS:
> >>>>> http://suspend.sf.net
> >>>> I know, I use swap files, and not a partition. This has prevented me from
> >>>> using suspend to disk "for ages". ;-)
> >>>>
> >>>> Is userspace suspend REQUIRED for this feature?
> >>> No, but unfortunately one piece is still missing: You'll need to figure out
> >>> where your swap file's header is located.
> >>>
> >>> However, if you apply the attached patch the kernel will tell you where it is
> >>> (after you do 'swapon' grep dmesg for 'swap' and use the value in the
> >>> 'offset' field).
> >> Nobody has answered this one yet:  Once you 'swapon' doesn't the kernel
> >> have (require?) the swap file opened writable?  Simple mode:
> >>
> >>   IS THIS NOT EXTREMELY DANGEROUS?
> >
> > The trick is that the FS hosting the swapfile is *not* mounted at all;
> > you don't even activate the swap. resume process uses the block number
> > (better: the couple <devid, block>) to locate the swapfile.
> > The "ugly" part of this method is that the user has to figure out the
> > first block of the swapfile, since at resume time it's not possibile to
> > mount the fs (not even read only - journaled filesystems will blow up
> > due to journal replay) to search the swap area...
> >
> 
> Yes, I was referring to Wysoki's comment about using swapon to find it.
>  Although I guess you could look beforehand; but then if you move the
> partition around on disk the block changes (and the kernel, on resume,
> goes "BOY WHAT IS WRONG WITH YOU?!" because the partition table is
> incorrect XD)

Well, if you change your partition table between the suspend and resume,
the resume will fail anyway (in the very best case).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
