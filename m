Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWEDWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWEDWvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWEDWvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:51:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38581
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932349AbWEDWvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:51:35 -0400
Date: Thu, 04 May 2006 15:51:25 -0700 (PDT)
Message-Id: <20060504.155125.68091905.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: vda@ilport.com.ua, linux-kernel@vger.kernel.org
Subject: Re: www.softpanorama.org: sparc_vs_x86 fun
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr>
References: <200605041224.41827.vda@ilport.com.ua>
	<Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Thu, 4 May 2006 13:31:37 +0200 (MEST)

> while on SPARC, it takes 6 instructions (of course, being RISC makes it 
> execute differently than x64)
> 
>     sethi %g1, $some_upper_bits
>     or %g1, $next_bitgroup
>     (shift-left)
>     or %g1, $next_bitgroup
>     (shift-left)
>     or %g1, $last_bitgroup
> 
> BTW, T1 is cool, but that the 1U version only has space for 1 disk is 
> pretty limiting :/

This example instruction sequence is incredibly misleading.

First of all, the vast majority of constants can be loaded in 1 to 3
instruction sequences.  I know this because I wrote the code that
emits 64-bit constant loading in the sparc backend of gcc and I've
watched how it tends to work when compiling real code.

Yes, the code density sucks on sparc compared to any x86 variant,
32-bit or 64-bit, but there is no need to exaggerate.

For symbolic references, it depends upon the code model and whether
you are generating PIC or not.  If you use the 32-bit medlow code
model, non-PIC, which is the default for apps being compiled under
sparc64/Linux, it's two instructions to load a symbol address.

The sequence gets progressively larger as you move onto the medmid
and midany code models.

