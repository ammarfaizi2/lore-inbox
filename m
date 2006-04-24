Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDXFXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDXFXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 01:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDXFXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 01:23:23 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:2440 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750724AbWDXFXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 01:23:22 -0400
Date: Mon, 24 Apr 2006 14:18:46 +0900 (JST)
Message-Id: <20060424.141846.31056103.taka@valinux.co.jp>
To: sekharan@us.ibm.com
Cc: akpm@osdl.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, " Valerie.Clement"@bull.net,
       kurosawa@valinux.co.jp
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1145683725.21231.15.camel@linuxchandra>
References: <1145670536.15389.132.camel@linuxchandra>
	<20060421191340.0b218c81.akpm@osdl.org>
	<1145683725.21231.15.camel@linuxchandra>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chandra, 

> > > > c) pointer to prototype code if poss
> > > 
> > > Both the memory controllers are fully functional. We need to trim them
> > > down.
> > > 
> > > active/inactive list per class memory controller:
> > > http://prdownloads.sourceforge.net/ckrm/mem_rc-f0.4-2615-v2.tz?download
> > 
> > Oh my gosh.  That converts memory reclaim from per-zone LRU to
> > per-CKRM-class LRU.  If configured.
> 
> Yes. We originally had an implementation that would use the existing
> per-zone LRU, but the reclamation path was O(n), where n is the number
> of classes. So, we moved towards a O(1) algorithm.
> 
> > 
> > This is huge.  It means that we have basically two quite different versions
> > of memory reclaim to test and maintain.   This is a problem.
> 
> Understood, will work and come up with an acceptable memory controller.
> > 
> > (I hope that's the before-we-added-comments version of the patch btw).
> 
> Yes, indeed :). As I told earlier this patch is not ready for lkml or -
> mm yet.
> > 
> > > pzone based memory controller:
> > > http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2
> > 
> > From a super-quick scan that looks saner.  Is it effective?  Is this the
> > way you're planning on proceeding?
> > 
> 
> Yes, it is effective, and the reclamation is O(1) too. It has couple of
> problems by design, (1) doesn't handle shared pages and (2) doesn't
> provide support for both min_shares and max_shares.

I'm not sure all of them have to be managed under ckrm_core and rcfs
in kernel.

These functions you mentioned can be implemented in user space
to minimize the overhead in usual VM operations because it isn't
expected quick response to resize it. It is a bit different from
that of CPU resource.

You don't need to invent everything. I think you can reuse what
NUMA team is doing instead. This approach may not fit in your rcfs,
though.

> > This requirement is basically a glorified RLIMIT_RSS manager, isn't it? 
> > Just that it covers a group of mm's and not just the one mm?
> 
> Yes, that is the core object of ckrm, associate resources to a group of
> tasks.

Thanks,
Hirokazu Takahahsi.
