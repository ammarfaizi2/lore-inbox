Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWEZLat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWEZLat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEZLat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:30:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14730 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932325AbWEZLas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:30:48 -0400
Date: Fri, 26 May 2006 13:31:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Message-ID: <20060526113101.GA19548@elte.hu>
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu> <200605261139.22193.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605261139.22193.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > Also, kmemleak guarantees (assuming the implementation is correct) 
> > that if a leak happens in practice, it will be detected immediately.
> 
> Not if the slab object is reused quickly - which it often is.

I dont see how slab object reuse could cause leak detection problems - 
if something _is_ being freed, it's not a leak. What matters are the 
objects that are 'forgotten' - and (at least statistically) kmemleak 
should find them, because after some time all references to them go 
away.

on 64-bit systems the statistical likelyhood of finding a leak could be 
even increased by artificially relocating the kernel to a semi-random 
base within the 64-bit address space. (that would mean that in practice 
that all kernel pointers would be 'marked' with the top 28-32 bits that 
are a good indicator of them being a kernel pointer)

	Ingo
