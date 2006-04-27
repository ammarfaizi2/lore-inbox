Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWD0XcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWD0XcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWD0XcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:32:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751753AbWD0XcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:32:19 -0400
Date: Thu, 27 Apr 2006 16:34:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm: i386 i8259.c simplify i8259A_irq_real()
Message-Id: <20060427163447.6c6c18a1.akpm@osdl.org>
In-Reply-To: <20060427221452.GA29019@rhlx01.fht-esslingen.de>
References: <20060427221452.GA29019@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
>
> Hello all,
> 
> I noticed the very "non-nice" asymmetry of i8259A_irq_real(),
> so I decided to fix the weirdly aligned branches.
> While doing this, I noticed that it could be streamlined much more,
> resulting in an astonishing 208 byte object code saving for such a tiny code
> fragment! (gcc 3.2.3)

It saves an astonishing two bytes here, with gcc-3.2.1

   text    data     bss     dec     hex filename
   1302     388      10    1700     6a4 arch/i386/kernel/i8259.o

   1300     388      10    1698     6a2 arch/i386/kernel/i8259.o

;)



And with gcc-4.2.0:

bix:/usr/src/25> size arch/i386/kernel/i8259.o
   text    data     bss     dec     hex filename
   1340     356      12    1708     6ac arch/i386/kernel/i8259.o

   1335     356      12    1703     6a7 arch/i386/kernel/i8259.o


