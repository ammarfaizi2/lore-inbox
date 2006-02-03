Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWBCRMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBCRMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBCRMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:12:10 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:11274 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751261AbWBCRMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:12:09 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Phillip Susi'" <psusi@cfl.rr.com>,
       "'Martin Drab'" <drab@kepler.fjfi.cvut.cz>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, "'Cynbe ru Taren'" <cynbe@muq.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>
Subject: RE: FYI: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 11:22:40 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <43E386F5.6090305@cfl.rr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYo33TbzAPkyNQARjGALr/dXCzr8AABi2Dw
Message-ID: <EXCHG2003ok84FTA7OI000011ea@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 03 Feb 2006 17:05:25.0122 (UTC) FILETIME=[065F9620:01C628E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Phillip Susi
> Sent: Friday, February 03, 2006 10:38 AM
> To: Martin Drab
> Cc: Bill Davidsen; Cynbe ru Taren; Linux Kernel Mailing List; 
> Salyzyn, Mark
> Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
> 
> Martin Drab wrote:
> > On Fri, 3 Feb 2006, Phillip Susi wrote:
> >   
> >> It looks like the problem is in that controller card and 
> its driver.  
> >> Was this a proprietary closed source driver?
> >>     
> >
> > No, it was the kernel's AACRAID driver 
> (drivers/scsi/aacraid/*). And 
> > I've consulted that with Mark Salyzyn who told me that it is the 
> > problem of the upper layers which are only zero fault tollerant and 
> > that driver con do nothing about it.
> >   
> 
> That's a strange statement, maybe we could get some 
> clarification on it?  From the dmesg lines you posted before, 
> it appeared that the hardware was failing the request with a 
> bad disk sense code.  As I said before, normally Linux has no 
> problem reading the good parts of a partially bad disk, so I 
> wonder exactly what Mark means by "upper layers which are 
> only zero fault tollerant"?


Some of the fakeraid controllers will kill the disk when the
disk returns a failure like that.

On top of that usually (even if the controller were not to
kill the disk) the application will get a fatal disk error
also, causing the application to die.

The best I have been able to hope for (this is a raid0 stripe
case) is that the fakeraid controller does not kill the disk,
returns the disk error to the higher levels and lets the application
be killed, at least in this case you will likely know the disk
has a fatal error, rather than (in the raid0 case) having the
machine crash, and have to debug it to determine exactly
what the nature of the failure was.

The same may need to be applied when the array is already
in degraded mode ... limping along with some lost data and messages
indicating such is a lot better that losing all of the data.

                           Roger

