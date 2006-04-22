Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWDVTcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWDVTcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWDVTcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:32:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751059AbWDVTcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:32:03 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net,
       Valerie Clement <" Valerie.Clement"@bull.net>,
       Takahiro Kurosawa <kurosawa@valinux.co.jp>
In-Reply-To: <20060421191340.0b218c81.akpm@osdl.org>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
	 <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 21 Apr 2006 22:28:45 -0700
Message-Id: <1145683725.21231.15.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 19:13 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > > 
> > > c) pointer to prototype code if poss
> > 
> > Both the memory controllers are fully functional. We need to trim them
> > down.
> > 
> > active/inactive list per class memory controller:
> > http://prdownloads.sourceforge.net/ckrm/mem_rc-f0.4-2615-v2.tz?download
> 
> Oh my gosh.  That converts memory reclaim from per-zone LRU to
> per-CKRM-class LRU.  If configured.

Yes. We originally had an implementation that would use the existing
per-zone LRU, but the reclamation path was O(n), where n is the number
of classes. So, we moved towards a O(1) algorithm.

> 
> This is huge.  It means that we have basically two quite different versions
> of memory reclaim to test and maintain.   This is a problem.

Understood, will work and come up with an acceptable memory controller.
> 
> (I hope that's the before-we-added-comments version of the patch btw).

Yes, indeed :). As I told earlier this patch is not ready for lkml or -
mm yet.
> 
> > pzone based memory controller:
> > http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2
> 
> From a super-quick scan that looks saner.  Is it effective?  Is this the
> way you're planning on proceeding?
> 

Yes, it is effective, and the reclamation is O(1) too. It has couple of
problems by design, (1) doesn't handle shared pages and (2) doesn't
provide support for both min_shares and max_shares.

> This requirement is basically a glorified RLIMIT_RSS manager, isn't it? 
> Just that it covers a group of mm's and not just the one mm?

Yes, that is the core object of ckrm, associate resources to a group of
tasks.

> 
> Do you attempt to manage just pagecache?  So if class A tries to read 10GB
> from disk, does that get more aggressively reclaimed based on class A's
> resource limits?

Yes, it would get more aggressively reclaimed. But, if you have the I/O
controller also configured appropriately only class A will be affected.

> 
> This all would have been more comfortable if done on top of the 2.4
> kernel's virtual scanner.
> 
> (btw, using the term "class" to identify a group of tasks isn't very
> comfortable - it's an instance, not a class...)

We could go with "Resource Group" as Matt suggested.
> 
> 

Valerie, KUROSAWA, Please free to add any more details.
> Worried.
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


