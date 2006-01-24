Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWAXAyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWAXAyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWAXAyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:54:23 -0500
Received: from amdext4.amd.com ([163.181.251.6]:12255 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030265AbWAXAyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:54:22 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Mon, 23 Jan 2006 18:53:54 -0600
User-Agent: KMail/1.8
cc: "Dave McCracken" <dmccr@us.ibm.com>, "Robin Holt" <holt@sgi.com>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601231816.38942.raybry@mpdtxmail.amd.com>
 <200601240139.46751.ak@suse.de>
In-Reply-To: <200601240139.46751.ak@suse.de>
MIME-Version: 1.0
Message-ID: <200601231853.54948.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 24 Jan 2006 00:53:55.0876 (UTC)
 FILETIME=[A724FE40:01C62080]
X-WSS-ID: 6FCBA52E0MS269349-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 18:39, Andi Kleen wrote:
> On Tuesday 24 January 2006 01:16, Ray Bryant wrote:
> > On Monday 23 January 2006 17:58, Ray Bryant wrote:
> > <snip>
> >
> > > ... And what kind of alignment constraints do we end up
> > > under in order to make the sharing happen?   (My guess would be that
> > > there aren't any such constraints (well, page alignment.. :-)  if we
> > > are just sharing pte's.)
> >
> > Oh, obviously that is not right as you have to share full pte pages.   So
> > on x86_64 I'm guessing one needs 2MB alignment in order to get the
> > sharing to kick in, since a pte page maps 512 pages of 4 KB each.
>
> The new randomized mmaps will likely actively sabotate such alignment. I
> just added them for x86-64.
>
> -Andi

Hmmm, does that mean there is a fundamental conflict between the desire to 
share pte's and getting good cache coloring behavior?

Isn't it the case that if the region is large enough (say >> 2MB), that 
randomized mmaps will just cause the first partial page of pte's to not be 
shareable, and as soon as we have a full pte page mapped into the file that 
the full pte pages will be shareable, etc, until the last (partial) pte page 
is not shareable?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

