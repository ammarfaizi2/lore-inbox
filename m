Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFLUy4>; Wed, 12 Jun 2002 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSFLUy4>; Wed, 12 Jun 2002 16:54:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6639 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314278AbSFLUyy>; Wed, 12 Jun 2002 16:54:54 -0400
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <ae89e2$qhs$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 13:54:55 -0700
Message-Id: <1023915295.1471.41.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-12 at 13:03, H. Peter Anvin wrote:

> while ( 1 ) {
>       disable_preemption();
>       cpu = current_cpu();
>       if ( decompression_buffers[cpu] ) {
> 	 do_decompression(decompression_buffers[cpu]);
> 	 enable_preemption();
> 	 break;		/* DONE, EXIT LOOP */
>       } else {
> 	 enable_preemption();
> 	 down_sem(allocation_semaphore);
> 	 /* Avoid race condition here */
> 	 if ( !decompression_buffers[cpu] )
> 	    decompression_buffers[cpu] = vmalloc(BUFFER_SIZE);
> 	 up_sem(allocation_semaphore);
>       }
> }

Just a note, in 2.5 we recently added put_cpu() and get_cpu() that work
basically like:

	int cpu;

	cpu = get_cpu();
	/* critical non-preemptible section */
	put_cpu();

i.e., a preempt-safe interface to smp_processor_id() that disables and
enables preemption for you... makes it a little easier.

	Robert Love

