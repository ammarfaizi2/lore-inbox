Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUIZOmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUIZOmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 10:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbUIZOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 10:42:04 -0400
Received: from jade.aracnet.com ([216.99.193.136]:63700 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S269553AbUIZOmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 10:42:02 -0400
Date: Sun, 26 Sep 2004 07:41:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all	set_pte must be written in asm
Message-ID: <228130000.1096209711@[10.10.2.4]>
In-Reply-To: <1096159487.18234.64.camel@gaston>
References: <20040925155404.GL3309@dualathlon.random> <1096155207.475.40.camel@gaston>  <20040926002037.GP3309@dualathlon.random> <1096159487.18234.64.camel@gaston>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> anyways on x86 the bug is real in practice, regardless of the C
>> compiler, heck we even put a smp_wmb() in between the two writes. The
>> fact all other archs are buggy in theory too is just a corollary. I
>> thought it worth to fix the theoretical bug in all other archs too,
>> instead of keeping playing russian roulette.
> 
> How so ? A bunch of archs have the pte beeing a simple long, on these
> set_pte is perfectly atomic as it is... I'd say in this regard that
> x86 is the exception ;)

Wouldn't it make sense to call set_pte_atomic, and just have that resolve
to set_pte on 90% of arches? (I'm ignoring the wierdo compiler issue here,
this is just for arches with pte > long). 

M.
