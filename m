Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVF1Npy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVF1Npy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVF1No0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:44:26 -0400
Received: from embeddededge.com ([209.113.146.155]:62218 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261759AbVF1NnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:43:14 -0400
In-Reply-To: <1119939502.5133.195.camel@gaston>
References: <20050626190944.GC6091@logos.cnet> <20050626.175347.104031526.davem@davemloft.net> <705a40397bb8383399109debccaebaa3@embeddededge.com> <20050627.125052.108115648.davem@davemloft.net> <dd805c30d3ab223b650077cca3c82d86@embeddededge.com> <1119939502.5133.195.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <08ca496673d593bf9dc7747bcc469dd5@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: increased translation cache footprint in v2.6
Date: Tue, 28 Jun 2005 09:42:53 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 28, 2005, at 2:18 AM, Benjamin Herrenschmidt wrote:

> Can't you put the "8Mb page" flag at the PMD level and use normal 
> kernel
> page tables ? You'll have to fill PMD entries two by two but that
> shouldn't be too difficult.

Yep.  You guys are suggesting all of the things that have been tried,
some more successfully than others.  The values in the pmd are just
half of the battle, you also need plenty of code to adjust the MMU
assist registers, copy stuff out of the ptes into the pmds, and so on.

None of this is new to me, I've been working on various solutions
for quite some time.  The only thing I'm going to do different now is
separate the paths for the user and kernel TLB miss handlers.  I
just never wanted the more frequently used 4K path to pay the
overhead of these other page sizes.  In the past, I tried to write
a single, fast code path for all cases, but it just doesn't work out.

Thanks.


	-- Dan

