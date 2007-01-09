Return-Path: <linux-kernel-owner+w=401wt.eu-S1751278AbXAIKdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXAIKdg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbXAIKdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:33:35 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1718 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbXAIKdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:33:35 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: Re: [PATCH] ppc: i8259 of_node_get cleanup
Date: Tue, 9 Jan 2007 11:33:52 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200701021247.42035.m.kozlowski@tuxland.pl>
In-Reply-To: <200701021247.42035.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701091133.52438.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 	This patch removes redundant argument check for of_node_get().
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  arch/powerpc/sysdev/i8259.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/i8259.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/i8259.c
> --- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/i8259.c	2006-12-24 05:00:32.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/i8259.c	2007-01-02 02:03:57.000000000 +0100
> @@ -276,8 +276,7 @@ void i8259_init(struct device_node *node
>  	spin_unlock_irqrestore(&i8259_lock, flags);
>  
>  	/* create a legacy host */
> -	if (node)
> -		i8259_node = of_node_get(node);
> +	i8259_node = of_node_get(node);
>  	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0);
>  	if (i8259_host == NULL) {
>  		printk(KERN_ERR "i8259: failed to allocate irq host !\n");

Paul, this patch is invalid as I overlooked the code comment that says it must allow node
be NULL. On the other hand it's never called with node == NULL. So either the comment
should change or do not apply this patch.

-- 
Regards,

	Mariusz Kozlowski
