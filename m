Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUAIEQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUAIEQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:16:49 -0500
Received: from dp.samba.org ([66.70.73.150]:11488 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263898AbUAIEQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:16:48 -0500
Date: Fri, 9 Jan 2004 15:15:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       ericy@cais.com
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking
Message-ID: <20040109041536.GB25504@krispykreme>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk> <20040108192021.6c2aea60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108192021.6c2aea60.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've always had little confidence in the elf loader.  The problem is
> complex, the code quality is not high and the consequences of an error are
> severe.

One thing I noticed is that we only obey execute permission on load
sections. On ppc32 the PLT is in the bss area and must be executable:

[27] .sbss             PROGBITS        100ba10c 0aa10c 000a14 00  WA 0   0  8
[28] .plt              PROGBITS        100bab20 0aab20 000834 00 WAX 0   0  4  
[29] .bss              NOBITS          100bb358 0ab354 003f90 00  WA 0   0  8

When I did per page execute for ppc64 we fell apart because the current
elf loader just creates a single region of non executable memory
regardless of what the binary asks for.

Anton
