Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWBFXar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWBFXar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWBFXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:30:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:13698 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964865AbWBFXar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:30:47 -0500
Date: Tue, 7 Feb 2006 00:29:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206232911.GB13566@elte.hu>
References: <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu> <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com> <20060206204111.GA20495@elte.hu> <Pine.LNX.4.62.0602061243200.18394@schroedinger.engr.sgi.com> <20060206210701.GA24446@elte.hu> <Pine.LNX.4.62.0602061406310.18919@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602061406310.18919@schroedinger.engr.sgi.com>
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


* Christoph Lameter <clameter@engr.sgi.com> wrote:

> > but a single object cannot be allocated both locally and globally!  
> > (well, it could be, for read-mostly workloads, but lets ignore that 
> > possibility) So instead of letting chance determine it, it is the most 
> > natural thing to let the object (or its container) determine which 
> > strategy to use - not the workload. This avoids the ambiguity at its 
> > core.
> 
> We want cpusets to make a round robin allocation within the memory 
> assigned to the cpuset. There is no global allocation that I am aware 
> of.

i think we might be talking about separate things, so lets go one step
back.

firstly, i think what you call roundrobin is what i call 'global'.  
[roundrobin allocation is what is best for a cache that is accessed in a 
'global' way - as opposed to cached data that is accessed in a 'local' 
way.]

secondly, i'm not sure i understood it correctly why you want to have 
all (mostly filesystem related) allocations within selected cpusets go 
in a roundrobin way. My understanding so far was that you wanted this 
because the workload attached to that cpuset was using the filesystem 
objects in a 'global' way: i.e. from many different nodes, with no 
particular locality of reference. Am i mistaken about this?

	Ingo
