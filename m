Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWDUVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWDUVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWDUVW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:22:56 -0400
Received: from over.co.us.ibm.com ([32.97.110.157]:35209 "EHLO
	over.co.us.ibm.com") by vger.kernel.org with ESMTP id S964788AbWDUVWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:22:55 -0400
Subject: Re: [PATCH] X86_NUMAQ build fix
From: Dave Hansen <haveblue@us.ibm.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87irp2x69s.fsf@duaron.myhome.or.jp>
References: <87irp2x69s.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 11:19:18 -0700
Message-Id: <1145643558.3373.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 01:06 +0900, OGAWA Hirofumi wrote:
> This patch fixes the build breakage of X86_NUMAQ. And this declares
> xquad_portio on only X86_NUMAQ.

What bug does this patch fix?  What is your .config?  I'm not having any
compile problems on my NUMAQ lately.

>  obj-$(CONFIG_PCI_DIRECT)       += direct.o
>  
>  pci-y                          := fixup.o
> -pci-$(CONFIG_ACPI)             += acpi.o
>  pci-y                          += legacy.o irq.o
>  
>  pci-$(CONFIG_X86_VISWS)                := visws.o fixup.o
>  pci-$(CONFIG_X86_NUMAQ)                := numa.o irq.o
>  
> +pci-$(CONFIG_ACPI)             += acpi.o

Am I reading this wrong, or does this just move the option down a bit?
Did you need to change the link order?  Why?

> +++ linux-2.6-hirofumi/arch/i386/boot/compressed/misc.c 2006-04-22 00:54:29.000000000 +0900
> @@ -122,7 +122,9 @@ static int vidport;
>  static int lines, cols;
>  
>  #ifdef CONFIG_X86_NUMAQ
> -static void * xquad_portio = NULL;
> +/* hack to avoid using xquad_portio=NULL */
> +#undef outb_p
> +#define outb_p         outb_local_p
>  #endif

It's really weird, but I'd hope that there was a reason for having two
xquad_portio.  Are you sure that this has no other consequences?

That said, it does boot on my 16-way NUMAQ, but I still have no real
idea what problem this is solving or what it is actually doing ;)

-- Dave

