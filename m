Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVALSoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVALSoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVALSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:44:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:28086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261227AbVALSoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:44:02 -0500
Date: Wed, 12 Jan 2005 10:43:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, ak@muc.de, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-Id: <20050112104326.69b99298.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>
	<m1652ddljp.fsf@muc.de>
	<Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
	<41E4BCBE.2010001@yahoo.com.au>
	<20050112014235.7095dcf4.akpm@osdl.org>
	<Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> > Do we have measurements of the negative and/or positive impact on smaller
>  > machines?
> 
>  Here is a measurement of 256M allocation on a 2 way SMP machine 2x
>  PIII-500Mhz:
> 
>   Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>    0  10    1    0.005s      0.016s   0.002s 54357.280  52261.895
>    0  10    2    0.008s      0.019s   0.002s 43112.368  42463.566
> 
>  With patch:
> 
>   Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>    0  10    1    0.005s      0.016s   0.002s 54357.280  53439.357
>    0  10    2    0.008s      0.018s   0.002s 44650.831  44202.412
> 
>  So only a very minor improvements for old machines (this one from ~ 98).

OK.  But have you written a test to demonstrate any performance
regressions?  From, say, the use of atomic ops on ptes?
