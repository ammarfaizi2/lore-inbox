Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTBTRfM>; Thu, 20 Feb 2003 12:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBTRdw>; Thu, 20 Feb 2003 12:33:52 -0500
Received: from mail.permas.de ([195.143.204.226]:2445 "EHLO netserv.local")
	by vger.kernel.org with ESMTP id <S266408AbTBTRdF>;
	Thu, 20 Feb 2003 12:33:05 -0500
From: Hartmut Manz <manz@intes.de>
Organization: INTES GmbH
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: allocate more than 2 GB on IA32
Date: Thu, 20 Feb 2003 18:40:21 +0100
User-Agent: KMail/1.5
References: <200302111015.54223.manz@intes.de> <86310000.1044979897@[10.10.2.4]>
In-Reply-To: <86310000.1044979897@[10.10.2.4]>
Cc: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302201840.21464.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 February 2003 17:11, Martin J. Bligh wrote:
> > i would like to allocate more than 2 GB of memory on an IA32
> > architecture.
> >
> > The machine is a dual XEON_DP with 3 GB of Ram and 4 GB of swap space.
> >
> > I have tried with the default SUSE 8.1 kernel as well as with a
> > 2.4.20-pre4aa1 Kernel compile by my own using these Options:
> >
> > CONFIG_HIGHMEM4G=y
> > CONFIG_HIGHMEM=y
> > CONFIG_1GB=y
> >
> > but I am only able to allocate 2 GB with a single malloc call.
> > I tought it should be possible to allocate up to 2.9 GB of memory to a
> > process, with this kernel settings.
>
> Well, assuming you had no user-space code or data, or a stack, or any
> shared libraries to fit into that space as well ;-)
>
> Try shifting TASK_UNMAPPED_BASE down from 1GB to 0.5GB - that should give
> you some more breathing room, though you'll never get to 2.9GB.
>
> M.

First of all I would like to say THANK YOU for your help.

I am now able to allocate up to ~3.2 GB of memory on a 4 GB Machine, even with 
shared libraries. 

This is what I have done.

1. I have activated the kernel option in  Kernel 2.4.21pre4aa3
   CONFIG_05GB=y
  This gives the following: 
    a: TASK_UNMAPPED_BASE is now 0xe000000 wich is  224 MB
    b: Upper Limit for User-Space memory is now at 3.5 GB
   So I have the potential to allocated up to 3360 MB of memory

2. I have exchanged malloc with anonymous mmap, since malloc
    was still only able to allocate about 2 GB.



-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Ein Mensch sieht, was vor Augen ist; der Herr aber sieht das Herz an.
------------------------------------------------------- 1. Samuel 16, 7 -----

