Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWGZLsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWGZLsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWGZLsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:48:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40084 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030231AbWGZLsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:48:05 -0400
Date: Wed, 26 Jul 2006 14:48:04 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com> <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Christoph Lameter wrote:
> If you disable them then we are fine. I think the main "bug" is that 
> we create the caches with ARCH_KMALLOC_MINALIGN in kmem_cache_init but 
> allow debug options on them. It seemss that we need to be able to disable 
> debugging from kmem_cache_init.

No, as Heiko explained, but bug is that we fail to respect architecture 
and caller mandated alignment when CONFIG_SLAB_DEBUG is enabled. With this 
patch (or Heiko's), we should be okay: http://lkml.org/lkml/2006/7/26/93

Note that this will fix the kmem_cache_init() case too. If 
ARCH_KMALLOC_MINALIGN is greater than BYTES_PER_WORD, we'll disable 
debugging for those caches. It's obviously ok to have debugging for 
kmem_cache_init caches too if ARCH_KMALLOC_MINALIGN is greater than or 
equal to BYTES_PER_WORD.

					Pekka
