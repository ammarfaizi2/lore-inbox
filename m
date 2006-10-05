Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWJEUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWJEUxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWJEUxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:53:40 -0400
Received: from smtpout.mac.com ([17.250.248.177]:15358 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932185AbWJEUxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:53:39 -0400
In-Reply-To: <4524D8DC.1080100@garzik.org>
References: <20061003001115.e898b8cb.akpm@osdl.org> <20061005083754.GA1060@elte.hu> <4524D8DC.1080100@garzik.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB232FE2-9E35-412E-869A-66BF871A6397@mac.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
Date: Thu, 5 Oct 2006 16:52:52 -0400
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 05, 2006, at 06:05:16, Jeff Garzik wrote:
> Ingo Molnar wrote:
>> A small suggestion: to give GCC folks a chance to actually fix  
>> this, could we actively annotate these places instead of working  
>> them around?
>
> There was a patch posted in the past, mentioned in the thread  
> discussed my #gccbug branch, that permitted annotations with zero  
> code size changes.  I think that sort of annotation approach would  
> be preferred. It was something like
>
> #define noinit_warning(x) \
> 	do { (void) (x) = (x); } while (0)
>
> but given my memory, that's probably all wrong.

The simplest way given the current GCC feature-set is:

   #ifdef HIDE_GCC_FALSE_POSITIVES
   # define correct_init(x) x = x
   #else
   # define correct_init(x) x
   #endif

Then:

   int correct_init(arg);
   struct some_struct correct_init(foo);

Alternatively if only some struct member has problems and the rest  
are OK:

   struct some_struct foo;
   correct_init(foo.bar);

Cheers,
Kyle Moffett

