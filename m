Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVBYGNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVBYGNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVBYGNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:13:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:6802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262627AbVBYGMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:12:40 -0500
Date: Thu, 24 Feb 2005 22:12:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 2.6.11-rc2-mm1 strange messages
In-Reply-To: <20050224181412.64a1f351.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502242210360.9237@ppc970.osdl.org>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
 <20050125102834.7e549322.akpm@osdl.org> <20050224141015.GA6756@gamma.logic.tuwien.ac.at>
 <20050224150326.3a82986c.akpm@osdl.org> <20050225012326.GA14302@gamma.logic.tuwien.ac.at>
 <20050224181412.64a1f351.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Feb 2005, Andrew Morton wrote:
> 
> Although a better fix might be to make __iounmap() behave symmetrically:
> 
> 	if ((long)addr >= phys_to_virt(0xA0000) &&
> 			(long)addr < phys_to_virt(0x100000))
> 		return;
> 
> but that's not quite right, because we're assuming that the range to be
> unmapped is wholly within the PCI/ISA region.  Without a VMA there just
> isn't enough info to determine that.
> 
> Does anyone have any preferences?

I think the "as symmetric as possible" thing is probably the thing to do. 
It might not be perfect in theory, but hey, practice is what matters. And 
in practice it's the "right thing", I think.

		Linus
