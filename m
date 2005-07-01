Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVGAWEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVGAWEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVGAWEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:04:10 -0400
Received: from animx.eu.org ([216.98.75.249]:13780 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262277AbVGAWBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:01:06 -0400
Date: Fri, 1 Jul 2005 18:16:17 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting uncompressed kernel image on i386?
Message-ID: <20050701221617.GA16873@animx.eu.org>
Mail-Followup-To: Ondrej Zary <linux@rainbow-software.org>,
	linux-kernel@vger.kernel.org
References: <42C13BF1.1040904@rainbow-software.org> <42C5BB4E.2040000@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C5BB4E.2040000@rainbow-software.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zary wrote:
> Nobody answered, time to look at the code :-)
> The attached patch is a quick hack so "make" will create uncompressed 
> kernel that can be booted in regular way.

> --- linux-2.6.12-printserver/arch/i386/boot/compressed/misc.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12-pentium/arch/i386/boot/compressed/misc.c	2005-07-01 23:34:55.000000000 +0200
> @@ -374,7 +374,15 @@
>  
>  	makecrc();
>  	putstr("Uncompressing Linux... ");

Would it not make sense to remove the above line?  You're not actually
uncompressing anything.

> -	gunzip();
> +	int i;
> +	for (i = 0; i < input_len / WSIZE; i++) {
> +		memcpy(window, input_data+i*WSIZE, WSIZE);
> +		outcnt = WSIZE;
> +		flush_window();
> +	}
> +	memcpy(window, input_data+i*WSIZE, input_len % WSIZE);
> +	outcnt = input_len % WSIZE;
> +	flush_window();
>  	putstr("Ok, booting the kernel.\n");
>  	if (high_loaded) close_output_buffer_if_we_run_high(mv);
>  	return high_loaded;

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
