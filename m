Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264582AbRGGQqq>; Sat, 7 Jul 2001 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266238AbRGGQqg>; Sat, 7 Jul 2001 12:46:36 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:5250 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264582AbRGGQqd>;
	Sat, 7 Jul 2001 12:46:33 -0400
Date: Sat, 7 Jul 2001 18:46:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Gold <mgold@scs.carleton.ca>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gamecon.c: Fix for SNES controllers
Message-ID: <20010707184609.N1749@suse.cz>
In-Reply-To: <20010705214908.B1943@linux.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010705214908.B1943@linux.box>; from mgold@scs.carleton.ca on Thu, Jul 05, 2001 at 09:49:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 09:49:08PM -0400, Michael Gold wrote:
> In kernel 2.4.4, a change was made to gamecon.c that causes problems
> with Super Nintendo controllers. The directional pad no longer works
> correctly - only the up and left directions work. The following patch
> fixes the problem by reversing the change. It applies cleanly to
> kernels 2.4.4, 2.4.5, and 2.4.6.
> 
> --- linux-2.4.4-orig/drivers/char/joystick/gamecon.c	Wed Apr 11 22:02:30 2001
> +++ linux-2.4.4/drivers/char/joystick/gamecon.c	Sat May 26 03:57:13 2001
> @@ -345,8 +345,8 @@
>  			s = gc_status_bit[i];
>  
>  			if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
> -				input_report_abs(dev + i, ABS_X, ! - !(s & data[6]) - !(s & data[7]));
> -				input_report_abs(dev + i, ABS_Y, ! - !(s & data[4]) - !(s & data[5]));
> +				input_report_abs(dev + i, ABS_X, !!(s & data[7]) - !!(s & data[6]));
> +				input_report_abs(dev + i, ABS_Y, !!(s & data[5]) - !!(s & data[4]));
>  			}
>  
>  			if (s & gc->pads[GC_NES])
> 

Already fixed in -ac series kernels. Thanks anyway.

-- 
Vojtech Pavlik
SuSE Labs
