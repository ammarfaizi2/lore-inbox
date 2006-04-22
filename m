Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWDVVFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWDVVFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWDVVFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:05:32 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62680 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751205AbWDVVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:05:31 -0400
Date: Fri, 21 Apr 2006 19:13:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Message-Id: <20060421191340.0b218c81.akpm@osdl.org>
In-Reply-To: <1145670536.15389.132.camel@linuxchandra>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	<1145630992.3373.6.camel@localhost.localdomain>
	<1145638722.14804.0.camel@linuxchandra>
	<20060421155727.4212c41c.akpm@osdl.org>
	<1145670536.15389.132.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> > 
> > c) pointer to prototype code if poss
> 
> Both the memory controllers are fully functional. We need to trim them
> down.
> 
> active/inactive list per class memory controller:
> http://prdownloads.sourceforge.net/ckrm/mem_rc-f0.4-2615-v2.tz?download

Oh my gosh.  That converts memory reclaim from per-zone LRU to
per-CKRM-class LRU.  If configured.

This is huge.  It means that we have basically two quite different versions
of memory reclaim to test and maintain.   This is a problem.

(I hope that's the before-we-added-comments version of the patch btw).

> pzone based memory controller:
> http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2

>From a super-quick scan that looks saner.  Is it effective?  Is this the
way you're planning on proceeding?

This requirement is basically a glorified RLIMIT_RSS manager, isn't it? 
Just that it covers a group of mm's and not just the one mm?

Do you attempt to manage just pagecache?  So if class A tries to read 10GB
from disk, does that get more aggressively reclaimed based on class A's
resource limits?

This all would have been more comfortable if done on top of the 2.4
kernel's virtual scanner.

(btw, using the term "class" to identify a group of tasks isn't very
comfortable - it's an instance, not a class...)


Worried.
