Return-Path: <linux-kernel-owner+w=401wt.eu-S1751283AbXAIKXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXAIKXt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXAIKXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:23:49 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4108 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbXAIKXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:23:48 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: cpm2_pic of_node_get cleanup
Date: Tue, 9 Jan 2007 11:24:03 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200701021236.20697.m.kozlowski@tuxland.pl> <17827.8109.461427.191194@cargo.ozlabs.ibm.com>
In-Reply-To: <17827.8109.461427.191194@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701091124.04949.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> Mariusz Kozlowski writes:
> 
> > 	This patch removes redundant argument check for of_node_get().
> > 
> > Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> > 
> >  arch/powerpc/sysdev/cpm2_pic.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
> > --- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
> > +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
> > @@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
> >  	cpm2_intctl->ic_scprrl = 0x05309770;
> >  
> >  	/* create a legacy host */
> > -	if (node)
> > -		cpm2_pic_node = of_node_get(node);
> > -
> > +	cpm2_pic_node = of_node_get(node);
> 
> This is actually a semantic change, in that cpm2_pic_node always gets
> assigned now, whereas previously it didn't if node == NULL.  Are you
> sure that is OK?  If so, you need to add something to the patch
> description explaining why it is OK.

It's ok to remove 'node' check because in real life cpm2_pic_init() never
gets called with node == NULL.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/cpm2_pic.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
@@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
 	cpm2_intctl->ic_scprrl = 0x05309770;
 
 	/* create a legacy host */
-	if (node)
-		cpm2_pic_node = of_node_get(node);
-
+	cpm2_pic_node = of_node_get(node);
 	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");


-- 
Regards,

	Mariusz Kozlowski
