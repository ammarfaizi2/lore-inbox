Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWHCBSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWHCBSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWHCBSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:18:07 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31699 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932102AbWHCBSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:18:05 -0400
Message-ID: <44D14ECC.3080600@vmware.com>
Date: Wed, 02 Aug 2006 18:18:04 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
References: <20060803002510.634721860@xensource.com> <20060803002518.061401577@xensource.com> <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com> <44D144EC.3000205@goop.org> <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Thats a good goal but what about the rest of us who have to maintain 
> additional forms of bit operations for all architectures. How much is this 
> burden? Are locked atomic bitops really that more expensive?
>   

It needn't be all architectures yet - only architectures that want to 
compile Xen drivers are really affected.  Perhaps a better place for 
these locking primitives is in a Xen-specific driver header which 
defines appropriate primitives for the architectures required?  Last I 
remember, there were still some issues here where atomic partial word 
operations couldn't be supported on some architectures.

To answer your question, yes.  On most i386 cores, locks destroy 
performance, and even unintentional use of a single locked operation in 
a critical path, on uncontended local memory, can have several hundred 
cycles downstream penalty.  I accidentally used one once during context 
switch, and saw a 30% reduction in switch performance - on a modern 
processor.

Zach
