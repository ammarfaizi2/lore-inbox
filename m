Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWIVS51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWIVS51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWIVS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:57:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbWIVS50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:57:26 -0400
Date: Fri, 22 Sep 2006 11:56:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Rientjes <rientjes@cs.washington.edu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [PATCH] do not free non slab allocated per_cpu_pageset
Message-Id: <20060922115646.fd1040e8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609221141270.8356@schroedinger.engr.sgi.com>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
	<20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921200806.523ce0b2.akpm@osdl.org>
	<20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921204629.49caa95f.akpm@osdl.org>
	<Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
	<Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
	<20060922113924.014ce28f.akpm@osdl.org>
	<Pine.LNX.4.64.0609221141270.8356@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:43:32 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 22 Sep 2006, Andrew Morton wrote:
> 
> > I think I preferred my earlier fix, recently reworked as:
> 
> The problem is though that the pcp pointers must point to the static pcp 
> arrays for bootup to succeed under NUMA. Your patch may work under SMP. 
> For NUMA you may zap pointers to valid static pcps.

This is unclear to me.  Do you mean "the pcps must be usable during
process_zones()'s call to kmalloc_node())" or do you mean "the pcps must
always be usable" (in which case more work needs to be done) or what?
