Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286358AbRLJSk6>; Mon, 10 Dec 2001 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286357AbRLJSkv>; Mon, 10 Dec 2001 13:40:51 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:33298 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S286358AbRLJSke>; Mon, 10 Dec 2001 13:40:34 -0500
Message-Id: <200112101840.fBAIeTg53340@aslan.scsiguy.com>
To: LBJM <LB33JM16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping 
In-Reply-To: Your message of "Sun, 09 Dec 2001 18:32:43 MST."
             <3C1410BB.6884E52F@yahoo.com> 
Date: Mon, 10 Dec 2001 11:40:29 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>When I upgraded to 2gigs of ram I was using 2.4.10 then used 2.4.14 and
>2.4.16 each did a kernel panic. however none do it with highmem off.

I am still investigating the cause of this particular problem.  In
fact we are building up a new system today in the hope of being able
to reproduce and solve this problem.

>I've also had the error locking at making tag count 64( somebody in the
>archives said that it doing that is normal. I've had that problem for
>years it doesn't hurt anything so I ignore it. so why does it do that?)

Its an informational message, not an error.  The system is telling
you that it has dynamically determined the maximum queue depth of
the device.

>I've read through the archives somebody posted the if they change the
>#define NSEG from 128 to 512 it goes away. it went away for me too when
>I did that and recomplied the kernel it went away for me too.
>I found this in aic7xxx_osm.h suggesting the 128 setting was only for
>highmem off
>/*
> * Number of SG segments we require.  So long as the S/G segments for
> * a particular transaction are allocated in a physically contiguous
> * manner and are allocated below 4GB, the number of S/G segments is
> * unrestricted.
> */

This is merely saying that the controller requires that the S/G list is
allocated below 4GB in the PCI bus address space (note that on some platforms
this may not mean the same thing as allocated within the first 4GB of
physical memory).

--
Justin
