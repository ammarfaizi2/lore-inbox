Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSKTMuR>; Wed, 20 Nov 2002 07:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSKTMuR>; Wed, 20 Nov 2002 07:50:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59826 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266042AbSKTMuQ>;
	Wed, 20 Nov 2002 07:50:16 -0500
Date: Wed, 20 Nov 2002 15:12:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       <riel@surriel.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: unusual scheduling performance
In-Reply-To: <20021118081854.GJ23425@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0211201504480.2559-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, William Lee Irwin III wrote:

> On 16x, 2.5.47 kernel compiles take about 26s when the machine is
> otherwise idle.
> 
> On 32x, 2.5.47 kernel compiles take about 48s when the machine is
> otherwise idle.

one thing to note is that the kernel's compilation is not something that
parallelizes well to above 8 CPUs. Our make architecture creates many link
points which serialize 'threads of compilation'.

i'd try two things:

 1) try Erich Focht's NUMA enhancements to the load balancer.

 2) remove the -pipe flag from arch/i386/Makefile

the later thing will reduce the number of processes and makes compilation
more localized to a single CPU - which might (or might not) help NUMA
architectures.

	Ingo

