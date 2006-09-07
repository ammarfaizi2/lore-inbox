Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWIGOaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWIGOaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWIGOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:30:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7108 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751775AbWIGOaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:30:08 -0400
Date: Thu, 7 Sep 2006 16:29:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <A93564A8-3F3A-4BA3-9557-F3D75BE59052@mac.com>
Message-ID: <Pine.LNX.4.64.0609071618590.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
 <20060907063049.GA15029@flint.arm.linux.org.uk> <20060907102740.GH25473@stusta.de>
 <20060907114358.GA26551@flint.arm.linux.org.uk> <A93564A8-3F3A-4BA3-9557-F3D75BE59052@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Kyle Moffett wrote:

> So it may be OK for sprintf(buf,"%s",str); to decay to strcpy(buf, str) in the
> kernel, but if it's not the ONLY ways to turn it off are -fno-builtin-sprintf,
> -fno-builtin, and -ffreestanding.  Explicitly disabling these optimizations is
> virtually guaranteed that we'll miss one, we should turn them all off and
> selectively enable the ones that make sense.

No, that would be a complete PITA and so far no arch maintainer wants to 
do this.
gcc cannot do arbitrary transformations, the result has to be the same 
according to the standard and since the standard functions we provide are 
standards compliant (modulo bugs, minus fp support) there is no problem. 
It's possible that gcc generates a call to a function we don't provide, 
but the resulting link failure is hard to miss.

bye, Roman
