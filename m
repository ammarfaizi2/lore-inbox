Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTBFOA5>; Thu, 6 Feb 2003 09:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTBFOA5>; Thu, 6 Feb 2003 09:00:57 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:61880 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267175AbTBFOA4>;
	Thu, 6 Feb 2003 09:00:56 -0500
Date: Thu, 6 Feb 2003 15:10:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Update of the input subsystem - 37 csets
Message-ID: <20030206151025.A10594@ucw.cz>
References: <20030206141352.A10182@ucw.cz> <20030206134939.A9732@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030206134939.A9732@infradead.org>; from hch@infradead.org on Thu, Feb 06, 2003 at 01:49:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 01:49:39PM +0000, Christoph Hellwig wrote:

>   * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
>   * This seems a good reason to start with NumLock off.
>   */
> +#ifndef CONFIG_X86_PC9800
>  #define KBD_DEFLEDS 0
> +#else
> +#define KBD_DEFLEDS (1 << VC_NUMLOCK)
> +#endif
>  #endif
> 
> This ifdef is the wrong way around.

The ifdef is the right way around. KBD_DEFLEDS used to be 0. Now
KBD_DEFLEDS is also 0, except when CONFIG_X86_PC9800 is defined. Note
it's an if*n*def there.

> But having something like
> 
> #ifndef KBD_DEFLEDS
> #define KBD_DEFLEDS 0
> #endif
> 
> and the PC98-specific stuff in a asm header sounds like a much better plan.

Yes. Send me a patch that does this, and I'll happily merge it in.

> --- bk/include/linux/serio.h	Thu Feb  6 13:10:36 2003
> +++ bk+input/include/linux/serio.h	Thu Feb  6 13:21:56 2003
> @@ -10,10 +10,13 @@
>   */
>  
>  #include <linux/ioctl.h>
> -#include <linux/list.h>
>  
>  #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
>  
> +#ifdef __KERNEL__
> +
> +#include <linux/list.h>
> 
> 
> Don't add more #ifdef __KERNEL__ - the kernel headers aren't supposed
> to be included from userspace.

Hmm. I know this isn't the prefered way of doing it, but so far it's the
most convenient one - serio.h still changes now and then (adding new
#defines, etc), and the only one program using it is inputattach.c. To
me it seems quite sane to have inputattach.c include this kernel header.
If you know of any other reasonably maintainable way to do it ...

-- 
Vojtech Pavlik
SuSE Labs
