Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWGZSYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWGZSYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWGZSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:24:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:27049 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751658AbWGZSYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:24:33 -0400
Message-ID: <44C7B352.9020307@colorfullife.com>
Date: Wed, 26 Jul 2006 20:24:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Christoph Lameter <clameter@sgi.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>	 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>	 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>	 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>	 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>	 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>	 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0607261529240.20519@sbz-30.cs.Helsinki.FI>	 <Pine.LNX.4.64.0607260823160.5647@schroedinger.engr.sgi.com> <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
In-Reply-To: <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

> Hi Christoph,
>
> On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
>
>> We intentionally discard the caller mandated alignment for debugging
>> purposes.
>
>
There are two different types of alignment:
- SLAB_HWCACHE_ALIGN: it's a recommendation, it's regularly ignored.
- the align parameter, or ARCH_SLAB_MINALIGN: It's mandatory. For 
example the pgd structures must be 4 kB aligned, it's required by the 
hardware. And I think there was (is?) a structure where ptr & ~(size-1) 
was used to find the start of the structure.

Thus the patch is correct, it's a bug in the slab allocator. If 
HWCACHE_ALIGN is set, then the allocator ignores align or 
ARCH_SLAB_MINALIGN.

--
    Manfred
