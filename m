Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbUKKA2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUKKA2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbUKKA0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:26:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:29130 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262166AbUKKAYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:24:15 -0500
Date: Wed, 10 Nov 2004 16:24:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Len Brown <len.brown@intel.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
In-Reply-To: <4192ADF4.1050907@conectiva.com.br>
Message-ID: <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br> <4192A9BF.2080606@conectiva.com.br>
 <4192ADF4.1050907@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Arnaldo Carvalho de Melo wrote:
>
> This one compiles and links OK.

Including when CONFIG_ACPI_BOOT is set? Does it see the prototype then? 
Looks like <asm/acpi.h> should be included, but I assume it gets included 
some other way?

Quite frankly, I think the whole thing is broken. #ifdef's inside code is 
_evil_, and "platform_rename_gsi()" doesn't make sense as a name. I'll 
apply your patch, but quite frankly, I think the ACPI layer is doing crap.

Len, can you please use a more descriptive name, and have it be always 
defined (make it an inline function that just becomes a no-op or 
something).

		Linus
