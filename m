Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWFIJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWFIJW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFIJW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:22:29 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:25881 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932241AbWFIJW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:22:28 -0400
Subject: Re: [PATCH 01/14] Per zone counter functionality
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       ak@suse.de, marcelo.tosatti@cyclades.com
In-Reply-To: <20060608210045.62129826.akpm@osdl.org>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	 <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
	 <20060608210045.62129826.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 11:22:13 +0200
Message-Id: <1149844934.20886.41.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 21:00 -0700, Andrew Morton wrote:
> On Thu, 8 Jun 2006 16:02:44 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:

> > +#ifdef CONFIG_SMP
> > +void refresh_cpu_vm_stats(int);
> > +void refresh_vm_stats(void);
> > +#else
> > +static inline void refresh_cpu_vm_stats(int cpu) { };
> > +static inline void refresh_vm_stats(void) { };
> > +#endif
> 
> do {} while (0), please.  Always.  All other forms (afaik) have problems. 
> In this case,
> 
> 	if (something)
> 		refresh_vm_stats();
> 	else
> 		foo();
> 
> will not compile.

It surely will, 'static inline' does not make it less of a function.
Although the trailing ; is not needed in the function definition.

