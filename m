Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWGZMbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWGZMbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGZMbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:31:15 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:28105 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751472AbWGZMbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:31:15 -0400
Date: Wed, 26 Jul 2006 15:31:13 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0607261529240.20519@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com>  <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
  <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Christoph Lameter wrote:
> The following patch adds an option SLAB_DEBUG_OVERRIDE to switch off
> debugging if its on by default. S390 would have to set ARCH_KMALLOC_FLAGS
> to SLAB_DEBUG_OVERRIDE. The flag will then be passed in 
> kmem_cache_init to kmem_cache_create(). This approach also preserves the 
> existing slab behavior for all other archs.

Please read my patch again. The rules are simple: we must disable 
debugging if architecture OR caller mandated alignment is greater than 
BYTES_PER_WORD. Note: for kmem_cache_init() the caller mandated alignment 
_is_ ARCH_KMALLOC_MINALIGN.

My patch takes care of _both_ ARCH_KMALLOC_MINALIGN and 
ARCH_SLAB_MINALIGN.

				Pekka
