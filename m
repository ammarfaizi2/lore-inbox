Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUEIEnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUEIEnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 00:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUEIEnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 00:43:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264271AbUEIEnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 00:43:16 -0400
Date: Sat, 8 May 2004 21:43:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405082138000.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
 <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com>
 <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
 <20040508211236.10481447.akpm@osdl.org> <Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 May 2004, Linus Torvalds wrote:
> 
> NOTE! It's absolutely true that DNAME_INLINE_LEN may still be different 
> from DNAME_INLINE_LEN_MIN. In particular, if something inside the struct 
> makes the alignment of "struct dentry" be bigger than the offset of the 
> last field, then DNAME_INLINE_LEN will be different from (bigger than) 
> DNAME_INLINE_LEN.

Btw, this does depend on the fact that a regular "kmem_cache_create()" 
with a alignment of 0 had better return a pointer that is always "aligned 
enough" for the architecture in question. 

But that had better be true anyway, since otherwise everything would 
basically have to specify the alignment by hand, and the alignment of 0 
would be useless.

		Linus
