Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSLDVUQ>; Wed, 4 Dec 2002 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSLDVUQ>; Wed, 4 Dec 2002 16:20:16 -0500
Received: from x101-201-249-dhcp.reshalls.umn.edu ([128.101.201.249]:9349 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S267094AbSLDVUP>;
	Wed, 4 Dec 2002 16:20:15 -0500
Date: Wed, 4 Dec 2002 15:27:43 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this patch okay?
Message-Id: <20021204152743.2f5c28fd.arashi@arashi.yi.org>
In-Reply-To: <Pine.LNX.4.44.0212042140540.4031-100000@dns.toxicfilms.tv>
References: <Pine.LNX.4.44.0212042140540.4031-100000@dns.toxicfilms.tv>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002 21:46:54 +0100 (CET)
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> Hello,
> 
> i downloaded 2.5.50, started compiling it, and it bailed out with an error
> in drivers/pci/quirks.c, that sis_apic_bug is not defined.
> I did a quick grep around the source and found a file to include.
> 
> Basically, this is what i did.
> 
> *** linux-2.5.50.old/drivers/pci/quirks.c       Wed Nov 27 23:35:48 2002
> --- linux-2.5.50/drivers/pci/quirks.c   Wed Dec  4 21:40:44 2002
> ***************
> *** 18,23 ****
> --- 18,24 ----
>   #include <linux/pci.h>
>   #include <linux/init.h>
>   #include <linux/delay.h>
> + #include <asm/io_apic.h>
> 
>   #undef DEBUG
> 
> Is it okay to include it like that?
> Or should it be fixed some other way? I am just getting around the kernel,
> though the kernel has one my small patch, i am definitelly no guru.

Hi, the fix in the -ac tree for this is to put "extern int sis_apic_bug;"
directly before its usage. Including <asm/io_apic.h> is incorrect because
while this file will compile on several platforms, io_apic.h only exists
on i386 and x86_64, so this would break on, say, Alpha.

Matt
