Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSFWQXa>; Sun, 23 Jun 2002 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSFWQX3>; Sun, 23 Jun 2002 12:23:29 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49122 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317056AbSFWQX3>; Sun, 23 Jun 2002 12:23:29 -0400
Date: Sun, 23 Jun 2002 09:21:54 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: "Christopher E. Brown" <cbrown@woods.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <4170280116.1024824112@[10.10.2.3]>
In-Reply-To: <3D157C7C.4080007@us.ibm.com>
References: <3D157C7C.4080007@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  >> Yep, 2 independent busses per quad.  That's a _lot_ of busses
>  >> when you have an 8 or 16 quad system.  (I wonder who has one of
>  >> those... ;) Almost all of the server-type boxes that we play with
>  >>  have multiple PCI busses.  Even my old dual-PPro has 2.
>  >
>  > I thought I saw 3 PCI and 1 ISA per-quad., but maybe that's the
>  > "independent" bit coming into play.
>  >
> Hmmmm.  Maybe there is another one for the onboard devices.  I thought
> that there were 8 slots and 4 per bus.  I could
> be wrong.  BTW, the ISA slot is EISA and as far as I can tell is only
> used for the MDC.

NUMA-Q has 2 PCI buses per quad, 3 slots in one, 4 in the other,
plus the EISA slots.

Multiple independant PCI buses are also available on other more
common architecutres, eg Netfinity 8500R, x360, x440, etc. 

Anything with the Intel Profusion chipset will have this feature,
the bottleneck becomes the "P6 system bus" backplane they're all
connected to, which has a theoretical limit of 800Mb/s IIRC, though
nobody's been able to get more than 420Mb/s out of it in practice,
as far as I know. 

The thing that makes the NUMA-Q a massive IO shovelling engine is
having one of these IO backplanes per quad too ... 16 x 800Mb/s
= 12.8Gb/s ;-)

M.

