Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbVKBVrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbVKBVrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVKBVq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:46:58 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:15368 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S965267AbVKBVq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:46:57 -0500
Date: Wed, 2 Nov 2005 22:49:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel library ordering
Message-ID: <20051102214931.GA18668@mars.ravnborg.org>
References: <Pine.LNX.4.64.0510311333320.5288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510311333320.5288@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:48:49PM -0500, Nicolas Pitre wrote:
> 
> In the latest kernel, there is an optimized sha1 routine 
> (arch/arm/lib/sha1.S) meant to override the generic one in lib/sha1.c.
> 
> The problem is that lib/lib.a is listed _before_ arch/arm/lib/lib.a in 
> the link argument list so the architecture specific lib functions are 
> not picked up in priority.
> 
> To work around this the following patch is needed:
> 
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -142,7 +142,7 @@ drivers-$(CONFIG_OPROFILE)      += arch/
>  drivers-$(CONFIG_ARCH_CLPS7500)	+= drivers/acorn/char/
>  drivers-$(CONFIG_ARCH_L7200)	+= drivers/acorn/char/
>  
> -libs-y				+= arch/arm/lib/
> +libs-y				:= arch/arm/lib/ $(libs-y)
>  
>  # Default target when executing plain make
>  ifeq ($(CONFIG_XIP_KERNEL),y)
> 
> However I was wondering if there should be a better and generic way to 
> fix that.
This looks like an obvious way to achive correct ordering.
We could change it so arch defines always took precedence but
the above is so simple that it is not worth the effort.

	Sam
