Return-Path: <linux-kernel-owner+w=401wt.eu-S1751061AbXAIFcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXAIFcr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXAIFcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:32:47 -0500
Received: from ozlabs.org ([203.10.76.45]:47014 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbXAIFcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:32:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17827.8109.461427.191194@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 15:53:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc: cpm2_pic of_node_get cleanup
In-Reply-To: <200701021236.20697.m.kozlowski@tuxland.pl>
References: <200701021236.20697.m.kozlowski@tuxland.pl>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Kozlowski writes:

> 	This patch removes redundant argument check for of_node_get().
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  arch/powerpc/sysdev/cpm2_pic.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
> --- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
> @@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
>  	cpm2_intctl->ic_scprrl = 0x05309770;
>  
>  	/* create a legacy host */
> -	if (node)
> -		cpm2_pic_node = of_node_get(node);
> -
> +	cpm2_pic_node = of_node_get(node);

This is actually a semantic change, in that cpm2_pic_node always gets
assigned now, whereas previously it didn't if node == NULL.  Are you
sure that is OK?  If so, you need to add something to the patch
description explaining why it is OK.

Paul.
