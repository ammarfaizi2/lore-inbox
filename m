Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVCQSj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVCQSj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVCQSj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:39:26 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:50856 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262382AbVCQSgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:36:37 -0500
Date: Thu, 17 Mar 2005 19:36:32 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, garloff@suse.de, ak@suse.de
Subject: Re: 2.6.11 vs 2.6.10 slowdown on i686
Message-ID: <20050317183632.GC12725@wotan.suse.de>
References: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 12:16:40PM +0000, Ian Pratt wrote:
> 
> Folks, 
> 
> When we upgraded arch xen/x86 to kernel 2.6.11, we noticed a slowdown
> on a number of micro-benchmarks. In order to investigate, I built
> native (non Xen) i686 uniprocessor kernels for 2.6.10 and 2.6.11 with
> the same configuration and ran lmbench-3.0-a3 on them. The test
> machine was a 2.4GHz Xeon box, gcc 3.3.3 (FC3 default) was used to
> compile the kernels, NOHIGHMEM=y (2-level only).

Hmm, it is known that x86-64 performance is down because it touches
a lot more memory now on fork/exit. I have some optimizations planned to fix
that, in fact it should be faster in the end.

i386 slowdowns are unexpected though.

I remember I tested i386 briefly with lmbench with my original 4level
patch, and there werent any significant slowdowns. However the patch
that eventually went into mainline was very different and in particular
clear_page_range() which is very critical looks completely different
now and does more work than before. Perhaps the slowdown happens in this
area.

diffprofile of before and after would be interesting.

-Andi
