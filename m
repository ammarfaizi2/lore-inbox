Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUA2QmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUA2QmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:42:20 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:31399 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265258AbUA2Ql7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:41:59 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH] 2.4.25pre7 warning fix
References: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58L.0401280939400.1311@logos.cnet>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 29 Jan 2004 17:38:49 +0100
In-Reply-To: <Pine.LNX.4.58L.0401280939400.1311@logos.cnet> (Marcelo
 Tosatti's message of "Wed, 28 Jan 2004 09:42:30 -0200 (BRST)")
Message-ID: <m3wu7azp46.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> Btw, why do we need cyclone_setup() for !CONFIG_X86_SUMMIT ?
>
> /* No-cyclone stubs */
> #ifndef CONFIG_X86_SUMMIT
> int __init cyclone_setup(char *str)
> {
>         printk(KERN_ERR "cyclone: Kernel not compiled with
> CONFIG_X86_SUMMIT, cannot use the cyclone-timer.\n");
>         return 1;
> }

After having a closer look at it I think we should:

1. if CONFIG_X86_TSC is set:
   - make calibrate_tsc() failure a fatal error
   - assume use_tsc = 1 and x86_udelay_tsc = 1 and optimize them out
     with preprocessor

2. if CONFIG_X86_SUMMIT is _not_ set:
   - assume use_cyclone = 0 and optimize it out as well.
   - cyclone_setup() etc should go out.

3. I would rename CONFIG_X86_TSC to something like CONFIG_X86_TSC_FORCE
   - the current name is misleading. It wouldn't affect .config.

This is all 2.4-only, as 2.6 is a little different here.

Comments?
-- 
Krzysztof Halasa, B*FH
