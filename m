Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTLWFe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 00:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbTLWFez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 00:34:55 -0500
Received: from fmr05.intel.com ([134.134.136.6]:23453 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264956AbTLWFev convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 00:34:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Mon, 22 Dec 2003 21:33:37 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187E6@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.0 batch scheduling, HT aware
Thread-Index: AcPI/iyEiH7iMWXoSAuzGIe7+4tikgAFeQEQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "Con Kolivas" <kernel@kolivas.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Dec 2003 05:33:38.0037 (UTC) FILETIME=[50E84A50:01C3C916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, Nick, does your SMT scheduler have "idle package prioritization"
which chooses an idle logical processor with the other local processor
idle if any (rather than just an idle processor with other local
processor running at full speed), when the scheduler requires an idle
local processor? That would prevent situations like two logical
processors run at full speed in the same processor package, with the
other processor package(s) idle in a same processor package(s). I
haven't reviewed your latest patch closely, and that is the one of the
things I want to do during the holidays.

One question. Why did you remove SD_FLAG_IDLE flag from cpu_domain
initialization in the w27 patch? We've been seeing some performance
degradation with w27, compared to w26.

Jun

> -----Original Message-----
> From: Nick Piggin [mailto:piggin@cyberone.com.au]
> Sent: Monday, December 22, 2003 6:41 PM
> To: Nakajima, Jun
> Cc: Con Kolivas; linux kernel mailing list
> Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
> 
> 
> 
> Nakajima, Jun wrote:
> 
> >Today utilization of execution resources of a logical processor is
> >around 60% as you can find in public papers, and it's dependent on
the
> >processor implementation and the workload. It could be higher in the
> >future, and their relative priority could be much higher then. So I
> >don't think it's a good idea to hard code such a
implementation-specific
> >factor into the generic scheduler code.
> >
> 
> No. The mechanism would be generic, but the parameters would be
> arch specific as part of my sched domains patch (if I have anything
> to do with it!)
> 

