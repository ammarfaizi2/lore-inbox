Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTFIMkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 08:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTFIMkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 08:40:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:30100 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264218AbTFIMkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 08:40:33 -0400
Date: Mon, 9 Jun 2003 14:54:04 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Fix PS/2 keyboard and mouse on I2000
Message-ID: <20030609145404.E25395@ucw.cz>
References: <16090.39595.933087.45491@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16090.39595.933087.45491@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Mon, Jun 02, 2003 at 10:30:35AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 10:30:35AM +1000, Peter Chubb wrote:
> 
> Hi,
> 	 The appended fix is needed on I2000 machines, to map the
> legacy ISA interrupt onto the actual interrupt provided.  Otherwise
> the mouse and keyboard won't work.  Patch against 2.5.70.

Thanks, applied.

> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1101  -> 1.1102 
> #	drivers/input/serio/i8042-io.h	1.4     -> 1.5    
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/05/27	peterc@gelato.unsw.edu.au	1.1102
> # IA64: Fix  I2000 no keyboard interrupt problem.
> # --------------------------------------------
> #
> diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> --- a/drivers/input/serio/i8042-io.h	Tue May 27 14:07:29 2003
> +++ b/drivers/input/serio/i8042-io.h	Tue May 27 14:07:29 2003
> @@ -20,11 +20,14 @@
>   */
>  
>  #ifdef __alpha__
> -#define I8042_KBD_IRQ	1
> -#define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
> +# define I8042_KBD_IRQ	1
> +# define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
> +#elif defined(__ia64__)
> +# define I8042_KBD_IRQ isa_irq_to_vector(1)
> +# define I8042_AUX_IRQ isa_irq_to_vector(12)
>  #else
> -#define I8042_KBD_IRQ	1
> -#define I8042_AUX_IRQ	12
> +# define I8042_KBD_IRQ	1
> +# define I8042_AUX_IRQ	12
>  #endif
>  
>  /*
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
