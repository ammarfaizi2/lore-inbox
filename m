Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWITS1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWITS1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWITS1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:27:13 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13814 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932213AbWITS1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:27:12 -0400
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: rohitseth@google.com
Cc: Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <1158776099.8574.89.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
	 <1158775586.28174.27.camel@lappy>
	 <1158776099.8574.89.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 20:27:04 +0200
Message-Id: <1158776824.28174.29.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 11:14 -0700, Rohit Seth wrote:
> On Wed, 2006-09-20 at 20:06 +0200, Peter Zijlstra wrote:
> > On Wed, 2006-09-20 at 10:52 -0700, Christoph Lameter wrote:
> > > On Wed, 20 Sep 2006, Rohit Seth wrote:
> > > 
> > > > Right now the memory handler in this container subsystem is written in
> > > > such a way that when existing kernel reclaimer kicks in, it will first
> > > > operate on those (container with pages over the limit) pages first.  But
> > > > in general I like the notion of containerizing the whole reclaim code.
> > > 
> > > Which comes naturally with cpusets.
> > 
> > How are shared mappings dealt with, are pages charged to the set that
> > first faults them in?
> > 
> 
> For anonymous pages (simpler case), they get charged to the faulting
> task's container.
> 
> For filesystem pages (could be shared across tasks running different
> containers): Every time a new file mapping is created, it is bound to a
> container of the process creating that mapping.  All subsequent pages
> belonging to this mapping will belong to this container, irrespective of
> different tasks running in different containers accessing these pages.
> Currently, I've not implemented a mechanism to allow a file to be
> specifically moved into or out of container. But when that gets
> implemented then all pages belonging to a mapping will also move out of
> container (or into a new container).

Yes, I read that in your patches, I was wondering how the cpuset
approach would handle this.

Neither are really satisfactory for shared mappings.

