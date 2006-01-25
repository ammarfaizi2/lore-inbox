Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWAYWFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWAYWFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAYWFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:05:44 -0500
Received: from [212.76.85.23] ([212.76.85.23]:60431 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932167AbWAYWFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:05:43 -0500
From: Al Boldi <a1426z@gawab.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Thu, 26 Jan 2006 01:04:57 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OF9B696195.5A30AEF3-ON882570FF.006879C2-882570FF.006D26D2@us.ibm.com>
In-Reply-To: <OF9B696195.5A30AEF3-ON882570FF.006879C2-882570FF.006D26D2@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601260104.57984.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
> >Perhaps you'd be interested in single-level store architectures, where
> >no distinction is made between memory and storage. IBM uses it in one
> >(or maybe more) of their systems.
>
> It's the IBM Eserver I Series, nee System/38 (A.D. 1980), aka AS/400.
>
> It was expected at one time to be the next generation of computer
> architecture, but it turned out that the computing world had matured to
> the point that it was more important to be backward compatible than to
> push frontiers.
>
> The single 128 bit address space addresses every byte of information in
> the system.  The underlying system keeps the majority of it on disk, and
> the logic that loads stuff into electronic memory when it has to be there
> is below the level that any ordinary program would see, much like the
> logic in an IA32 CPU that loads stuff into processor cache.  It's worth
> noting that nowhere in an I Series machine is a layer that looks like a
> CPU Linux runs on; it's designed for single level storage from the gates
> on up through the operating system.
>
> I found Al's dream rather vague, which explains why several people
> inferred different ideas from it (and then beat them down).  It sort of
> sounds like single level storage, but also like virtual memory and like
> mmap.  I assume it's actually supposed to be something different from all
> those.

Not really different, but rather an attempt to use hardware in a 
native/direct fashion w/o running circles.  But first let's look at the 
reasons that led the industry to this mem/disk personality split.

Consider these archs:
	bits	space
	8	256
	16	64K
	32	4G
	64	16GG=16MT
	128	256GGGG=256TTT
	
It follows that with 
	8 and 16 bits you are forced to split
	32 is inbetween
	64 is more than enough for most purposes
	128 is astronomical for most purposes
	 :
	 :

So we have a situation right now that imposes a legacy solution on hardware 
that is really screaming (64+) to be taken advantage of.  This does not mean 
that we have to blow things out of proportion and reinvent the wheel, but 
instead revert the workaround that was necessary in the past (-32).  

If reverted properly, things should be completely transparent to user-space 
and definitely faster, lots faster, especially under load.  Think about it.

Thanks!

--
Al

