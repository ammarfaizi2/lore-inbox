Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWJEKFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWJEKFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWJEKFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:05:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26330 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751593AbWJEKFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:05:23 -0400
Message-ID: <4524D8DC.1080100@garzik.org>
Date: Thu, 05 Oct 2006 06:05:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
References: <20061003001115.e898b8cb.akpm@osdl.org> <20061005083754.GA1060@elte.hu>
In-Reply-To: <20061005083754.GA1060@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> A small suggestion: to give GCC folks a chance to actually fix this, 
> could we actively annotate these places instead of working them around?


There was a patch posted in the past, mentioned in the thread discussed 
my #gccbug branch, that permitted annotations with zero code size 
changes.  I think that sort of annotation approach would be preferred. 
It was something like

#define noinit_warning(x) \
	do { (void) (x) = (x); } while (0)

but given my memory, that's probably all wrong.

So, I agree that annotations are a good idea, but I'm not so sure that 
your proposed "= 0" approach is the best one.  Remember, we need to do 
this for multi-member structures, integers, and pointers, not just 
things easily assigned to zero.

	Jeff


