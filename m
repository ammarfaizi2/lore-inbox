Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUHTCRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUHTCRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHTCRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:17:17 -0400
Received: from fmr12.intel.com ([134.134.136.15]:44735 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265245AbUHTCRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:17:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH futex on fusyn (Was: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1)
Date: Thu, 19 Aug 2004 19:15:42 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F942C@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH futex on fusyn (Was: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1)
Thread-Index: AcSFuZ3C5alHcAPgQc2D7zSaR6ZIQAAoKNkA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 20 Aug 2004 02:16:11.0285 (UTC) FILETIME=[A93F2450:01C4865B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar [mailto:mingo@elte.hu]
> * Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
> 
> > Performance:
> 
> > Environment                       Seconds (10 continuous runs averaged)
> > -----------                       -------------------
> > plain NPTL and futexes            0.97
> > plain NPTL, futexes use fuqueues  1.15
> > Under RTNPTL, using fulocks       1.48
> 
> hm, nice - only ~18% slowdown for a very locking-intense workload. If
> that could be made somewhat lower (without bad compromises) it would
> kill most of the performance-based objections.

That's what I am working on now. As I cannot find no obvious 
bottlenecks, I am playing with some simple, small random optimizations
[mostly centered around the hash table lookup code, vl_find*()].
If that doesn't yield any quick improvements, I'll have to dig
further and think some more.

Volanomark is showing some slowdown too, although smaller. However,
seems on the right track.

> the RTNPTL overhead (+~30%) is to be expected i guess - but it's
> optional so no pain.

Still it is too much--I need to at least cut that in half.

Will let you know as soon as I have some new stuff.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
