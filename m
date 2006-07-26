Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWGZSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWGZSHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWGZSHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:07:14 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:13737 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751091AbWGZSHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:07:13 -0400
Message-ID: <44C7AF31.9000507@colorfullife.com>
Date: Wed, 26 Jul 2006 20:06:41 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI> <20060726101340.GE9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI> <20060726105204.GF9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

>On Wed, 26 Jul 2006, Heiko Carstens wrote:
>  
>
>>We only specify ARCH_KMALLOC_MINALIGN, since that aligns only the kmalloc
>>caches, but it doesn't disable debugging on other caches that are created
>>via kmem_cache_create() where an alignment of e.g. 0 is specified.
>>
>>The point of the first patch is: why should the slab cache be allowed to chose
>>an aligment that is less than what the caller specified? This does very likely
>>break things.
>>    
>>
>
>Ah, yes, you are absolutely right. We need to respect caller mandated 
>alignment too. How about this?
>
>  
>
Good catch - I obviously never tested the code for an HWCACHE_ALIGN cache...


>			Pekka
>
>[PATCH] slab: respect architecture and caller mandated alignment
>
>Ensure cache alignment is always at minimum what the architecture or 
>caller mandates even if slab debugging is enabled.
>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>  
>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

--
    Manfred
