Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVEENN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVEENN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVEENN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:13:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39894 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262098AbVEENNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:13:51 -0400
Date: Thu, 5 May 2005 18:56:55 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050505132655.GA4028@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <4277F52B.8040908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277F52B.8040908@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 03:03:23PM -0700, Matthew Dobson wrote:
> An interesting feature.  I tried a while ago to get cpusets and
> sched_domains to play nice (nicer?) and didn't have much luck.  It seems
> you're taking a better approach, with smaller patches.  Good luck!

Thanks ! I would very much like to know your findings as far as
memory/node domains are concerned or are you going to be working on it?
I dont have any thoughts on it right now

> > -#ifdef CONFIG_HOTPLUG
> > +#if defined(CONFIG_HOTPLUG) || defined(CONFIG_CPUSETS)
> >  #define __devinit
> >  #define __devinitdata
> >  #define __devexit
> 
> This looks just plain wrong.  Why do you need this?  It doesn't seem that
> arch_init_sched_domains() and/or update_sched_domains() are called from
> anywhere that is cpuset related, so why the #ifdef CONFIG_CPUSETS?

cpu_attach_domain is defined as a __devinit, maybe I need to remove that
instead of the #ifdef

> >  #ifdef CONFIG_SMP
> > -#define SCHED_DOMAIN_DEBUG
> > +#undef SCHED_DOMAIN_DEBUG
> >  #ifdef SCHED_DOMAIN_DEBUG
> >  static void sched_domain_debug(struct sched_domain *sd, int cpu)
> >  {
> 
> Is this just to quiet boot for your testing?  Is there are better reason
> you're turning this off?  It seems unrelated to the rest of your patch.
> 

This gets called from cpu_attach_domain, and so everytime partitioning is done
and not only during boot with my changes

Thanks for your review !

	-Dinakar
