Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUL3FDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUL3FDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 00:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUL3FDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 00:03:48 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:34906 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261536AbUL3FDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 00:03:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=bER8Zt65vzOM2NVGl0HgfNbtMJGuElM2XB8TOLRHRNOcr4so4VXJUekin4Yvz6VUIOZa8xYjDiDxvyWTp7fc8O/sTpfM8RqCnaTSgQeFlwLIHIiV80+4oJ5SeIssOCYQ1CEtrEz7UVWVHyrEgrp4kbONOczD19mzM5chFzaB2S8=
Message-ID: <e7b30b240412292103319e92c0@mail.gmail.com>
Date: Thu, 30 Dec 2004 13:03:43 +0800
From: Mildred Frisco <mildred.frisco@gmail.com>
Reply-To: Mildred Frisco <mildred.frisco@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to initialize resource on linux 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am porting for mx1 board and I am wondering how to initialize device
resources or adding 'struct resource' in linux 2.4.20.  In 2.6 kernel,
this is done in generic.c by

--------------------------------
...
...
static struct platform_device imx_uart2_device = {
       .name           = "imx-uart",
       .id             = 1,
       .num_resources  = ARRAY_SIZE(imx_uart2_resources),
       .resource       = imx_uart2_resources,
};

static struct imxfb_mach_info imx_fb_info;

void __init set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info)
{
       memcpy(&imx_fb_info,hard_imx_fb_info,sizeof(struct imxfb_mach_info));
}
EXPORT_SYMBOL(set_imx_fb_info);

static struct resource imxfb_resources[] = {
       [0] = {
               .start  = 0x00205000,
               .end    = 0x002050FF,
               .flags  = IORESOURCE_MEM,
       },
       [1] = {
               .start  = LCDC_INT,
               .end    = LCDC_INT,
               .flags  = IORESOURCE_IRQ,
       },
};

static u64 fb_dma_mask = ~(u64)0;

static struct platform_device imxfb_device = {
       .name           = "imx-fb",
       .id             = 0,
       .dev            = {
               .platform_data  = &imx_fb_info,
               .dma_mask       = &fb_dma_mask,
               .coherent_dma_mask = 0xffffffff,
       },
       .num_resources  = ARRAY_SIZE(imxfb_resources),
       .resource       = imxfb_resources,
};

static struct platform_device *devices[] __initdata = {
       &imx_mmc_device,
       &imxfb_device,
       &imx_uart1_device,
       &imx_uart2_device,
};

void __init
imx_map_io(void)
{
       iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
}

static int __init imx_init(void)
{
       return platform_add_devices(devices, ARRAY_SIZE(devices));
}

subsys_initcall(imx_init);

-------------------------------------------------

'struct platform_device' doesn't seem to exist in 2.4.  On what part
of the code should I  create a 'struct resource' for a particular
device so that the driver can use it?

Thanks,
Mildred
