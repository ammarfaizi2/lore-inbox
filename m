Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWBWQQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWBWQQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWBWQQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:16:04 -0500
Received: from amdext4.amd.com ([163.181.251.6]:27277 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751591AbWBWQQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:16:02 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
Date: Wed, 22 Feb 2006 22:15:41 -0600
User-Agent: KMail/1.8
cc: "Jes Sorensen" <jes@sgi.com>, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1140686152.2972.25.camel@laptopd505.fenrus.org>
 <yq0zmkigsxf.fsf@jaguar.mkp.net>
 <1140698357.4672.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1140698357.4672.46.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Message-ID: <200602222215.42412.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 23 Feb 2006 16:15:37.0544 (UTC)
 FILETIME=[61E65C80:01C63894]
X-WSS-ID: 6FE300231VK1964961-01-01
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 06:39, Arjan van de Ven wrote:
> On Thu, 2006-02-23 at 07:29 -0500, Jes Sorensen wrote:
> > >>>>> "Arjan" == Arjan van de Ven <arjan@intel.linux.com> writes:
> >
> > Arjan> In a micro-benchmark that stresses the pagefault path, the
> > Arjan> down_read_trylock on the mmap_sem showed up quite high on the
> > Arjan> profile. Turns out this lock is bouncing between cpus quite a
> > Arjan> bit and thus is cache-cold a lot. This patch prefetches the
> > Arjan> lock (for write) as early as possible (and before some other
> > Arjan> somewhat expensive operations). With this patch, the
> > Arjan> down_read_trylock basically fell out of the top of profile.
> >
> > Out of curiousity, how big was the box used for testing? It might be
> > worth investigating if anything can be done to reduce the number of
> > times that lock is taken in the first place.
> >
> > After all, what's a pain on a 4-way tends to be an utter nightmare on
> > a 16-way ;(
>
> most of it was done on a 2 way, but some tests were done on a 4-way.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Could you share your microbenchmark with us (or point to the source) and we 
can give this a try on larger systems?   

Thanks,
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

