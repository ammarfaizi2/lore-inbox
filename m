Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSJOJcm>; Tue, 15 Oct 2002 05:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSJOJcm>; Tue, 15 Oct 2002 05:32:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29969 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264620AbSJOJcl>; Tue, 15 Oct 2002 05:32:41 -0400
Date: Tue, 15 Oct 2002 10:38:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
Message-ID: <20021015103833.C9771@flint.arm.linux.org.uk>
References: <20021015100024.A9771@flint.arm.linux.org.uk> <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Oct 15, 2002 at 11:14:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:14:03AM +0200, Geert Uytterhoeven wrote:
> So the generic part of the code should behave like this:
> 
>   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
>       /* use hardware blanking */
>   } else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> 	     info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
>       /* use software blanking */
>   } else {
>       /* no blanking possible, except for filling the screen with black, which
> 	 is not appropriate (unless we save/restore the contents?) */
>   }
> 
> Is that OK for you?

That's fine for me, but I'd expect other people to find problems with it.

Would it not be better to allow drivers to decide which type of blanking
they want to use depending on the current parameters set via the set_par
callback?  Only the drivers themselves know what their fb_blank method is
capable of performing.

I think with the above you'll inadvertently encourage drivers to mundge
the fb_blank function pointer in their set_par method.

There is also the argument about wanting soft blanking, but hardware power
saving.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

