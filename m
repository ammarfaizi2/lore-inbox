Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754660AbWKHUOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbWKHUOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbWKHUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:14:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754660AbWKHUON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:14:13 -0500
Date: Wed, 8 Nov 2006 12:13:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] nvidiafb: fix unreachable code in nv10GetConfig
Message-Id: <20061108121311.29dd0bda.akpm@osdl.org>
In-Reply-To: <20061108195511.GK17028@localdomain>
References: <20061108195511.GK17028@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 13:55:11 -0600
Nathan Lynch <ntl@pobox.com> wrote:

> Fix binary/logical operator typo which leads to unreachable code.
> Noticed while looking at other issues; I don't have the relevant
> hardware to test this.
> 
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> 
> --- linux-2.6-powerpc.git.orig/drivers/video/nvidia/nv_setup.c
> +++ linux-2.6-powerpc.git/drivers/video/nvidia/nv_setup.c
> @@ -262,7 +262,7 @@ static void nv10GetConfig(struct nvidia_
>  #endif
>  
>  	dev = pci_find_slot(0, 1);
> -	if ((par->Chipset && 0xffff) == 0x01a0) {
> +	if ((par->Chipset & 0xffff) == 0x01a0) {
>  		int amt = 0;
>  
>  		pci_read_config_dword(dev, 0x7c, &amt);

That looks like a pretty significant bug.  It'll cause the kernel to
potentially map the wrong amount of memory for all cards except the
NV_ARCH_04 type.  Has been there for over a year though.  hmm..
