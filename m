Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267949AbUHKKoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267949AbUHKKoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHKKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:44:23 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:51374 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S267949AbUHKKoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:44:19 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Wed, 11 Aug 2004 12:42:04 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, Hubertus Franke <frankeh@watson.ibm.com>,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       ckrm-tech@lists.sourceforge.net
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040810043120.23aaf071.pj@sgi.com> <41194E49.2000300@watson.ibm.com>
In-Reply-To: <41194E49.2000300@watson.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111242.04142.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 00:38, Shailabh Nagar wrote:
> >  Metrics, transactions, tasks, and resource
> >     decisions all have to be tracked or managed by Class.
> > 
> >     These Classes form a fairly shallow hierarchy of usage levels or
> >     service qualities, as perceived by the end users of the system.
> > 
> >     I'd guess that the average lifetime of a Class is months or years,
> >     as they can reflect the relative priority of relations with long
> >     standing, external customers.
> > 
> > Cpusets and CKRM have profoundly different purposes, economics and
> > motivations.
> 
> I would say the methods differ, not the purpose. Both are trying to 
> performance-isolate groups of tasks - one uses the spatial dimension of 
> cpu bindings, the other uses  the temporal dimension of cpu time.

So the purpose is different, too. With your words: spatial versus
temporal separation. They are orthogonal. In physics terms: you need
both to describe the universe and you cannot transform the one into
the other. Both make sense, they can be combined to give more benefit
(aehm, control).


> The other point of difference is the one you'd brought up earlier - ther 
> restrictions on the hierarchy creation. CKRM has none (effectively), 
> cpusets has many.

Don't know how it's exactly implemented, but the restrictions should
not be at hierarchy creation time (i.e. when creating the class
(cpusets) subdirectory). They should be imposed when setting/changing
the attributes. Writing illegal values to the virtual attribute files
must simply fail. And each resource controller knows best what it
allows for and what not, this shouldn't be a task of the
infrastructure (CKRM).


> As CKRM's interface stands today, there are sufficient differences 
> between the interfaces to keep them separate.
> 
> However, if CKRM moves to a model where
> - each controller is allowed to define its own virtual files and attributes
> - each controllers has its own hierarchy (and hence more control over 
> how it can be formed),
> then the similarities will be too many to ignore merger possibilities
> altogether.
> 
> The kicker is, we've not decided. The splitting of controllers into 
> their own hierarchy is something we're considering independently (as a 
> consequence of Linus' suggestion at KS04). But making the interface 
> completely per-controller is something we can do, without too much 
> effort, IF there is sufficient reason (we have other reasons for doing 
> that as well - see recent postings on ckrm-tech).

Having controller specifics less hidden is good because usage becomes
more intuitive and you don't have to RTFM (controller specific manuals
would have to be written, too). One file per attribute is also nicer
than several attributes hidden in a shares files. Adding an attribute
means adding a file, it doesn't break the old interface, so this is
easier to maintain. And, as you mentioned, some files in the current
CKRM interface just don't make sense for some resources. But a sane
ruleset provided by CKRM for external controllers should be
there. For example something like:
   - Class members are added by writing to the vitual file "target".
   - Class members are listed by reading the virtual file "target" and
     the format is ...
   - Each class attribute should be controlled by one file named
     appropriately. Etc...
   - Members of a class can register a callback which will be invoked
     when following events occur:
        - the class is destroyed
	- ... ?
   - etc ...

> Interest/recommendations from the community that cpusets  be part of 
> CKRM's hierarchy would certainly be a factor in that decision.

I'd prefer a single entry point for resource management with
consistent (not necessarilly same) and easy to use user interfaces for
all resources.

Regards,
Erich

