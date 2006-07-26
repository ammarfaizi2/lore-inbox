Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWGZMfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWGZMfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWGZMfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:35:05 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49079 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751588AbWGZMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:35:02 -0400
Date: Wed, 26 Jul 2006 15:35:00 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0607261532130.20519@sbz-30.cs.Helsinki.FI>
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

On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> > > Your patch only deals with ARCH_SLAB_MINALIGN. kmem_cache_create() never
> > > uses ARCH_KMALLOC_MINALIGN only kmem_cache_init() does by passing it to
> > > kmem_cache_create.  ARCH_KMALLOC_MINALIGN will still be ignored.
 
On Wed, 26 Jul 2006, Pekka Enberg wrote:
> > Yes, in which case the caller mandated align will be, well,
> > ARCH_KMALLOC_MINALIGN. The patch changes kmem_cache_create to respect
> > caller mandated alignment too.

On Wed, 26 Jul 2006, Christoph Lameter wrote:
> As far as I understood Heiko s390 does not set ARCH_SLAB_MINALIGN
> because they do not want alignent for all caches.

Correct. Heiko sets ARCH_KMALLOC_MINALIGN which will be passed as the 
'align' parameter to kmem_cache_create -- also known as 'caller mandated 
alignment.'

My patch changes the code so that, if either architecture or 
caller mandated alignment is greater than BYTES_PER_WORD, 
kmem_cache_create will disable debugging. Do you now see why my patch is 
in fact _not_ ignoring ARCH_KMALLOC_MINALIGN, but instead respecting that.

			Pekka
