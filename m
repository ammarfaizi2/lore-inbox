Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266421AbTGJTXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbTGJTXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:23:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10446 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266421AbTGJTXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:23:10 -0400
Date: Thu, 10 Jul 2003 20:37:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add xbox subarchitecture
Message-ID: <20030710193751.GI1939@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
> --- a/include/asm-i386/timex.h	Thu Jul 10 18:07:08 2003
> +++ b/include/asm-i386/timex.h	Thu Jul 10 18:07:08 2003
> @@ -15,7 +15,11 @@
>  #ifdef CONFIG_MELAN
>  #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
>  #else
> -#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
> +#  ifdef CONFIG_X86_XBOX
> +#    define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
> +#  else 
> +#    define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
> +#  endif
>  #endif
>  #endif

How about more simply:

 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#elif defined(CONFIG_X86_XBOX)
+#  define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
