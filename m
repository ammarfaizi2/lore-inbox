Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWFLQyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFLQyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFLQyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:54:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25229 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750722AbWFLQyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:54:43 -0400
Date: Mon, 12 Jun 2006 09:54:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606121848.05438.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <20060612114857.GA14616@elte.hu>
 <Pine.LNX.4.64.0606120921130.18975@schroedinger.engr.sgi.com>
 <200606121848.05438.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> > #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
> 
> It is also affected by your race. The inc would only be atomic if the counter
> was in the PDA, but standard per cpu data isn't. So it has to follow 
> a pointer and then it could already have switched.

I thought the above would refer to a PDA memory area that is specially 
mapped by each processor? That is the only thing that would get this 
working right because we would map to a different PDA if the process 
would be mapped to a different processor.

> Fix would be to disable preemption. I don't think it needs cli/sti
> on non preemptible kernels.

Yuck. The advantage of local.t was that it does not need any of these 
tricks. What is the point of local.t if one needs to disable preemption?
