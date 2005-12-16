Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVLPTOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVLPTOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVLPTOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:14:19 -0500
Received: from mail1.kontent.de ([81.88.34.36]:44681 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932460AbVLPTOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:14:17 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 20:14:35 +0100
User-Agent: KMail/1.8
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl> <43A30D36.5090406@didntduck.org> <1134759731.2992.57.camel@laptopd505.fenrus.org>
In-Reply-To: <1134759731.2992.57.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512162014.35965.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Dezember 2005 20:02 schrieb Arjan van de Ven:
> 
> > 
> > So what about arches where single-page stacks aren't viable (for example 
> > x86_64)?  Are we just screwed?
> 
> 
> x86 is specially handicapped due to the fact that the stacks need to be
> in the lowmem zone. Even if you have 8Gb ram, the lowmem zone is still
> 800Mb and a bit, and this gets to be under a high pressure, like
> hyper-fragmentation. Same for bounce buffers etc etc.
> 
> note that the order thing is by far not the only advantage, pure memory
> usage alone and cache locality also are wins. The memory usage halves
> for kernel stacks after all (which means you can do more threads in
> java, or use the memory for disk cache ;)

1. Cache usage depends on actual stack usage. How much you allocate
doesn't matter
2. You are surely getting a cache effect by using interrupt stacks. Which
is larger?
3. When you use kmalloc instead of the stack you are reducing locality.

	Regards
		Oliver
