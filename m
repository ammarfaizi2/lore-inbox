Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281493AbRKPWKm>; Fri, 16 Nov 2001 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKPWKc>; Fri, 16 Nov 2001 17:10:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281479AbRKPWKZ>; Fri, 16 Nov 2001 17:10:25 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mmap not working?
Date: 16 Nov 2001 14:10:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9t42rs$5vd$1@cesium.transmeta.com>
In-Reply-To: <200111162134.WAA22927@cave.bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111162134.WAA22927@cave.bitwizard.nl>
By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
In newsgroup: linux.dev.kernel
>
> 
> Hi,
> 
> I want to mmap a device in an application, so I do: 
> 
> 	base = mmap(NULL ,  DEV_LENGTH,  myprot , flags, kmem, dev_base); 
> 
> Turns out that some BIOSs put my device at an address like
> 
> 	0xdffffc00
> 
> whereas others put it at 0xfa000000 . In the latter case, mmap works
> as expected. However in the first case I get EINVAL: The base is
> not page-aligned. 
> 
> However, in the latter case I get my requested 1k of memory, and the
> following 3k for free. In the first case I'd want "3k for free,
> followed by the 1k I requested".
> 
> effectively, provided "start" equals NULL, the kernel IMHO should:
> 
> 	offset = dev_base & PAGE_MASK; 
> 	return mmap (NULL, length+offset, prot, flags, base - offset) + offset; 
> Comments?
> 
> The "failure" was observed on 2.4.14 and/or 2.4.9. 
> 
> 		Roger. 
> 
> 
> P.S. I end up not being able to closely follow linux-kernel
> lately. CCs to me appreciated.
> 

Sorry, what you're asking for the TLB to do something it simply cannot
do -- there is no way for the TLB to remap the bottom 12 bits since it
doesn't control them.

What you'd have to do is to make your device driver move the device to
a different address.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
