Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWITSP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWITSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWITSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:15:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36297 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932202AbWITSP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:15:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=EQiW2W1Q1LCMwuy2iB7SHEwLib4Ytnx0Zwnkgmb/6NPOfbKcGS67WYhcoJTasM89H
	90ZMzUgOME63MQm6ta2+A==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <1158775586.28174.27.camel@lappy>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
	 <1158775586.28174.27.camel@lappy>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 11:14:59 -0700
Message-Id: <1158776099.8574.89.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 20:06 +0200, Peter Zijlstra wrote:
> On Wed, 2006-09-20 at 10:52 -0700, Christoph Lameter wrote:
> > On Wed, 20 Sep 2006, Rohit Seth wrote:
> > 
> > > Right now the memory handler in this container subsystem is written in
> > > such a way that when existing kernel reclaimer kicks in, it will first
> > > operate on those (container with pages over the limit) pages first.  But
> > > in general I like the notion of containerizing the whole reclaim code.
> > 
> > Which comes naturally with cpusets.
> 
> How are shared mappings dealt with, are pages charged to the set that
> first faults them in?
> 

For anonymous pages (simpler case), they get charged to the faulting
task's container.

For filesystem pages (could be shared across tasks running different
containers): Every time a new file mapping is created, it is bound to a
container of the process creating that mapping.  All subsequent pages
belonging to this mapping will belong to this container, irrespective of
different tasks running in different containers accessing these pages.
Currently, I've not implemented a mechanism to allow a file to be
specifically moved into or out of container. But when that gets
implemented then all pages belonging to a mapping will also move out of
container (or into a new container).

-rohit

