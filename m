Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278205AbRJWTZd>; Tue, 23 Oct 2001 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278197AbRJWTZY>; Tue, 23 Oct 2001 15:25:24 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48917 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278207AbRJWTZN>; Tue, 23 Oct 2001 15:25:13 -0400
Date: Tue, 23 Oct 2001 15:25:47 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT370/366 testers needed
Message-ID: <20011023152547.E27797@redhat.com>
In-Reply-To: <3BD5A007.C07388ED@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD5A007.C07388ED@sun.com>; from thockin@sun.com on Tue, Oct 23, 2001 at 09:51:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 09:51:19AM -0700, Tim Hockin wrote:
> All,
> 
> We have this (attached) large patch for the HighPoint driver. 
> Specifically, it deals with HPT370 controllers, and should make them MUCH
> more stable (Adrian spent weeks on the phone with HighPoint).
> 
> What I'd like is for people to test this patch on other systems with
> HighPoint 370 controllers.  Also, I need people with HPT366 chips to test,
> and find any problems - we don't have HPT366 here to test.

> Volunteers?

I don't have any HighPoint controllers here, but I did spot a bug in 
the patch that's easy to fix:

> -#if 0
> -	if (test != 0x08)
> -		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0x08);
> -#else
>  	if (test != (L1_CACHE_BYTES / 4))
>  		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
> -#endif

This isn't correct on current Athlon and P4 machines running kernels 
compiled for i686.  One approach is to only set the cache line size if 
the bios set it to something less than we expect it to, or to leave 
this kind of pci hackery to the generic pci layer.  It's important to
note that quite a few drivers share this bug at present.  Cheers,

		-ben
