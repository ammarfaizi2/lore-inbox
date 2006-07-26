Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWGZLcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWGZLcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGZLcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:32:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6339 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751426AbWGZLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:32:53 -0400
Date: Wed, 26 Jul 2006 14:32:51 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com> <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka Enberg wrote:
> > This is the bit I missed, sorry. I thought that the s390 hardware
> > mandates 8 byte alignment, but it really doesn't. So you're absolutely
> > right, you don't need to set ARCH_SLAB_MINALIGN and the alignment
> > calculation in slab is indeed broken for both, architecture and caller
> > mandated alignments.

On Wed, 26 Jul 2006, Christoph Lameter wrote:
> Well that is a bit far reaching. What is broken is that SLAB_RED_ZONE and
> SLAB_STORE_USER ignore any given alignment. If you want to fix that then 
> you need to modify how both debugging methods work.

Not sure I understand what you mean. Isn't it enough that we disable 
debugging if architecture or caller mandated alignment is greater than 
BYTES_PER_WORD?

				Pekka 
