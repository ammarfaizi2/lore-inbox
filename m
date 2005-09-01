Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVIAIRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVIAIRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVIAIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:17:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5022 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965086AbVIAIRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:17:12 -0400
Date: Thu, 1 Sep 2005 10:17:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
Message-ID: <20050901081753.GA7952@elte.hu>
References: <20050901072430.GA6213@elte.hu> <4316B82B.2060306@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4316B82B.2060306@rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Ingo Molnar wrote:
> >is this the right way to fix the UP assumption below?
> >
> >	Ingo
> >
> >Signed-off-by: Ingo Molnar <mingo@elte.hu>
> >
> >Index: linux/drivers/ide/pci/alim15x3.c
> > [snip]
> 
> OK. The reported boot WARNING seems to be over now. Tested on the 
> offended laptop (P4@2.53Ghz/UP, PCI chipset: ALi M1533) with 
> 2.6.13-rt3, where the suggested patch on drivers/ide/pci/alim15x3.c 
> seems to fix the burp. All seems to be working fine, still ;)

just to make sure the original point gets across: the warning is only in 
the -rt tree, and it pinpoints potential SMP bugs. Does your box do 
hyperthreading? If yes then this could be a live (but probably mostly 
harmless) SMP bug. Maybe the whole IRQ disabling is unnecessary?  
__devinit is mostly serialized, so i'm not sure there's any protection 
needed against parallel IRQs?

	Ingo
