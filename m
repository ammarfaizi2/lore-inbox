Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266586AbUF3IWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbUF3IWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266588AbUF3IWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:22:54 -0400
Received: from everest.2mbit.com ([24.123.221.2]:41890 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266586AbUF3IWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:22:52 -0400
Message-ID: <40E2783D.5040108@greatcn.org>
Date: Wed, 30 Jun 2004 16:22:21 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
References: <40E162EF.7010607@greatcn.org>
In-Reply-To: <40E162EF.7010607@greatcn.org>
X-Scan-Signature: f67f5ee3df3e663546312f3fab1145ec
X-SA-Exim-Connect-IP: 218.24.174.116
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] share all PFN_* 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.174.116 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

> Hello all,
>
> There's too many macros definitions PFN_UP PFN_DOWN PFN_PHYS PFN_ALIGN 
> scattered all over.
> How about a patch move them all into one header file(kernel.h or init.h)
> and share only one copy of them like what min and max. I'd like to 
> make it.
>
>
>       coywolf
>
This patch splits out asm-generic/page.h and includes it at the bottom
of all arch specific page.h's.

This approach is more easy and *safe* than move the macros into kernel.h
or other, and also prepares for future. By nested into page.h, we can make
sure it's no problem to simply remove those definitions without adding new
include statements.

Here is it. http://greatcn.org/~coywolf/patches/2.6/share-PFN.patch


btw, these are all identical replacements, except on arm26(Matt Heler 
told me).
Arm26 implementation has done too much on this point.

On arm26:  #define PFN_UP(x) (PAGE_ALIGN(x) >> PAGE_SHIFT)
PAGE_ALIGN is no use here since >> followed

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

