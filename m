Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVCNUYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVCNUYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCNUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:24:14 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:43828 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261859AbVCNUWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:22:12 -0500
Date: Mon, 14 Mar 2005 21:22:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, Amos Waterland <apw@us.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 debugging symbols for boot wrapper
Message-ID: <20050314202218.GA17925@mars.ravnborg.org>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
	Amos Waterland <apw@us.ibm.com>, anton@samba.org,
	linux-kernel@vger.kernel.org
References: <16949.957.650893.747905@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16949.957.650893.747905@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 02:23:41PM +1100, Paul Mackerras wrote:
> This patch is from Amos Waterland <apw@us.ibm.com>.
> 
> It is really useful when debugging early boot on simulator to have debug
> symbols in the 32-bit code that uncompresses the kernel proper.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
> diff -urN linux-2.5/arch/ppc64/boot/Makefile test/arch/ppc64/boot/Makefile
> --- linux-2.5/arch/ppc64/boot/Makefile	2005-03-07 10:46:38.000000000 +1100
> +++ test/arch/ppc64/boot/Makefile	2005-03-14 13:42:34.000000000 +1100
> @@ -27,6 +27,11 @@
>  BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
>  OBJCOPYFLAGS    := contents,alloc,load,readonly,data
>  
> +ifdef CONFIG_DEBUG_INFO
> +BOOTCFLAGS		+= -g
> +BOOTAFLAGS		+= -g
> +endif

Please change it to use:
bootflags-y  := -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
bootflags-$(CONFIG_DEBUG_INFO) += -g

And same for BOOTAFLAGS.

	Sam
