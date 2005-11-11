Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVKKTl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVKKTl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVKKTl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:41:57 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:16140 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751108AbVKKTl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:41:56 -0500
Message-ID: <4374F3EB.6040103@shadowen.org>
Date: Fri, 11 Nov 2005 19:41:31 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [PATCH] Allow flatmem to be disabled when only sparsemem is implemented
References: <20051111160341.GK14770@krispykreme> <4374DA3D.6050704@shadowen.org>
In-Reply-To: <4374DA3D.6050704@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Anton Blanchard wrote:
> 
>>On architectures that implement sparsemem but not discontigmem we want
>>to be able to hide the flatmem option in some cases. On ppc64 for
>>example, when we select NUMA we must not select flatmem.
> 
> First reaction is that this is very reasonable.  I can see why you need
> to do this as you don't have DISCONTIGMEM.  I will just go check the
> major architectures and make sure they arn't relying on being able to
> enable SPARSEMEM and getting FLATMEM too behaviour.  I don't think they
> can be as they all have DISCONTIGMEM and so should be insulated.

Ok.  I've reviewed the usage of the memory model selectors in the
architectures in 2.6.14-mm2.  It appears that only i386 is affected by
this change, the others that use the selector have explicit enablement
of FLATMEM.  This patch will interact badly with the current code to
enable SPARSEMEM on non-numa systems.  However, this code is under
review at this moment, and the proposed replacement (Message-ID:
<4370BC30.40100@shadowen.org>) is compatible with this change.

In short as long as they go in together this change looks good.

Magnus, any feedback on the replacement SPARSEMEM enabler on non-NUMA
i386 systems??

-apw
