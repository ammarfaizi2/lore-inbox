Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVKWV2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVKWV2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVKWV2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:28:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39627 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932529AbVKWV2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:28:24 -0500
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org, ak@muc.de
In-Reply-To: <20051123.132440.71355611.davem@davemloft.net>
References: <20051123002134.287ff226.akpm@osdl.org>
	 <20051123.005530.17893365.davem@davemloft.net>
	 <1132737084.2795.20.camel@laptopd505.fenrus.org>
	 <20051123.132440.71355611.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 22:28:19 +0100
Message-Id: <1132781300.2795.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 13:24 -0800, David S. Miller wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> Date: Wed, 23 Nov 2005 10:11:24 +0100
> 
> > it can.. but only if we start using -ffunction-sections in the CFLAGS
> > (or make all of these functions static I suppose and reenable
> > -funit-at-a-time, which can be done for gcc 4.x only)
> 
> I actually just scanned the tree, and outside of files that
> only get built on CONFIG_SMP (namely, arch/${ARCH}/kernel/smp{,boot}.c)
> the IPI functions were %99 marked static already and the remaining
> %1 should be marked static.  The cases in that %1 group are:

static is good anyway :)

> 
> arch/mips/sibyte/sb1250/prom.c:prom_cpu0_exit()
> arch/powerpc/kernel/machine_kexec_64.c:kexec_smp_down()
> 
> And as stated, those two can just be marked static right now.
> 
> So we could very easily remove the CONFIG_SMP ifdefs, but the
> -funit-at-a-time requirement to get gcc to not emit unused static
> functions is very unfortunate.

I'm no gcc expert but afaik this really needs unit-at-a-time. (someone
who knows more about gcc please correct me if I'm wrong).

On the good news side:
-f-unit-at-a-time can be enabled for gcc 4.x; the stack bug that caused
it to be disabled is fixed in gcc 4.x

and .. -ffunction-sections may well be a good thing anyway; that works
even for non-statics.
(but iirc it needs some linker script changes because sections change
name)

