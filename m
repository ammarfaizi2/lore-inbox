Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263495AbUJ3Elt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbUJ3Elt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 00:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbUJ3Elt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 00:41:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:54742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263495AbUJ3Ekh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 00:40:37 -0400
Message-ID: <41831A1D.3030901@osdl.org>
Date: Fri, 29 Oct 2004 21:35:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: adaplas@hotpop.com
Subject: Re: [PATCH] fbdev: Convert MODULE_PARM to module_param in neofb
References: <200410292312.i9TNCsDq006882@hera.kernel.org>
In-Reply-To: <200410292312.i9TNCsDq006882@hera.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2337.1.21, 2004/10/29 13:24:51-07:00, adaplas@hotpop.com
> 
> 	[PATCH] fbdev: Convert MODULE_PARM to module_param in neofb
> 	Convert MODULE_PARM to module_param in neofb
> 	
> diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
> @@ -100,18 +100,18 @@
>  MODULE_AUTHOR("(c) 2001-2002  Denis Oliver Kropp <dok@convergence.de>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("FBDev driver for NeoMagic PCI Chips");
> -MODULE_PARM(internal, "i");
> +module_param(internal, bool, 0);
>  MODULE_PARM_DESC(internal, "Enable output on internal LCD Display.");
> -MODULE_PARM(external, "i");
> +module_param(external, bool, 0);
>  MODULE_PARM_DESC(external, "Enable output on external CRT.");
> -MODULE_PARM(libretto, "i");
> +module_param(libretto, bool, 0);
>  MODULE_PARM_DESC(libretto, "Force Libretto 100/110 800x480 LCD.");
> -MODULE_PARM(nostretch, "i");
> +module_param(nostretch, bool, 0);
>  MODULE_PARM_DESC(nostretch,
>  		 "Disable stretching of modes smaller than LCD.");
> -MODULE_PARM(nopciburst, "i");
> +module_param(nopciburst, bool, 0);
>  MODULE_PARM_DESC(nopciburst, "Disable PCI burst mode.");
> -MODULE_PARM(mode_option, "s");
> +module_param(mode_option, charp, 0);
>  MODULE_PARM_DESC(mode_option, "Preferred video mode ('640x480-8@60', etc)");

Since neofb_setup() still parses options, what does this do?
Provide 2 ways of passing options/arguments?

Same questions for intelfb and i810fb.

Oh, is it this?
neofb_setup() is used for non-modular option parsing,
and module_param() is used for modular or non-modular option parsing.

IOW, using neofb_setup() for option parsing maintains some
backward compatibility for options?

-- 
~Randy
