Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWIVTKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWIVTKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIVTKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:10:25 -0400
Received: from mx4.cs.washington.edu ([128.208.4.190]:56737 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S932169AbWIVTKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:10:23 -0400
Date: Fri, 22 Sep 2006 12:10:10 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do not free non slab allocated per_cpu_pageset
In-Reply-To: <Pine.LNX.4.64.0609221203020.8675@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64N.0609221209130.8288@attu2.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921204629.49caa95f.akpm@osdl.org> <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
 <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
 <20060922113924.014ce28f.akpm@osdl.org> <Pine.LNX.4.64.0609221141270.8356@schroedinger.engr.sgi.com>
 <20060922115646.fd1040e8.akpm@osdl.org> <Pine.LNX.4.64.0609221203020.8675@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Christoph Lameter wrote:

> The pcps must be usable during process_zones() for NUMA bootstrap. 
> As far as I recall: A cpu is booted with the static arrays and later 
> process_zones is replacing the references to the static arrays.
> 

Yes, they are replaced as soon as the slab allocator is up.  So all we 
need is to prevent static pcp's from being free'd since they haven't yet 
matured to being slab.

		David
