Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUCMJKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 04:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbUCMJKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 04:10:44 -0500
Received: from [212.209.10.220] ([212.209.10.220]:4277 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S263062AbUCMJKm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 04:10:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] kref, a tiny, sane, reference count object
Date: Sat, 13 Mar 2004 10:10:36 +0100
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB36613F@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] kref, a tiny, sane, reference count object
Thread-Index: AcQI1LSi9PAIbqF2RHOB0CfcnkCAmwABJ5sA
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Mar 2004 09:10:36.0959 (UTC) FILETIME=[0C3FE2F0:01C408DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg KH
> Sent: Saturday, March 13, 2004 09:20
> To: linux-kernel@vger.kernel.org
> Subject: [RFC] kref, a tiny, sane, reference count object
> 
> In thinking about people's complaints about the current 
> kobject interface, a lot of people don't like the 
> "complexity" of what is necessary to use a kobject.
> If all you want is something to handle reference 
> counting properly, a kobject can seem a bit "large".
> 
> For all of those people, this patch is for you.  
> Introducing struct kref.  A tiny (only 8 bytes on a 
> 32bit platform) that will properly handle reference 
> counting any structure you want to use it for.  Note 
> that you will have to be careful around the cleanup 
> period (but that can be easily handled by the user 
> with regards to not trying to grab a "new" reference
> if you don't already have one, once the object is 
> gone, just like kobjects and sysfs today work.)
> 
> I've implemented kobjects using a kref to handle the 
> reference counting portion, but will leave that patch
> and change for 2.7, as it will add 4 more bytes (on a 
> 32bit platform) to every kobject, and that wouldn't 
> be nice this early in the 2.6 series.  For now, krefs 
> can stand on their own.
> 
> I've already found loads of places in the kernel that 
> can use this structure to clean up their logic, and 
> will probably be converting a number of them over time 
> to use them.  But no, Al, I will not say this can be 
> used to replace the atomic_t count you have in inodes, 
> as that count is horribly abused in ways I never really 
> wanted to know about (negative counts mean something 
> "special"?  eeeeeek....)
> 
> Anyway, here's a patch against 2.6.4 that adds krefs
> to the kernel.  I'll follow up with a patch that 
> converts the usb-serial core from using kobjects to 
> using krefs instead.
> 
> Comments are appreciated and welcomed.
> 
> thanks,
> 
> greg k-h

Looks simple enough.  But I have a small question. 
In kref_get() and kref_cleanup(), kref is verified 
not to be NULL before being used.  However, this is 
not done in kref_put().  An oversight, or as intended?

//Peter
