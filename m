Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVKFUp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVKFUp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKFUp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:45:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751219AbVKFUpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:45:25 -0500
Date: Sun, 6 Nov 2005 21:45:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       dkrivoschokov@dev.rtsoft.ru
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
Message-ID: <20051106204506.GH29901@elf.ucw.cz>
References: <20051103221402.GA28206@elf.ucw.cz> <1131057308.8523.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131057308.8523.92.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is there recent version somewhere? I found one version
> > (pxa27x-0218.patch), but it is *really* old.
> 
> Pull it out of handhelds.org kernel26 cvs tree and let me and the usb
> developers have the patch please :)

I got it to compile it for me, but I'd probably need something like

/*
 * USB Device Controller
 */
static void corgi_udc_command(int cmd)
{
        switch(cmd)     {
        case PXA2XX_UDC_CMD_CONNECT:
                GPSR(CORGI_GPIO_USB_PULLUP) =
GPIO_bit(CORGI_GPIO_USB_PULLUP);
                break;
        case PXA2XX_UDC_CMD_DISCONNECT:
                GPCR(CORGI_GPIO_USB_PULLUP) =
GPIO_bit(CORGI_GPIO_USB_PULLUP);
                break;
        }
}

static struct pxa2xx_udc_mach_info udc_info __initdata = {
        /* no connect GPIO; corgi can't tell connection status */
        .udc_command            = corgi_udc_command,
};

...for the spitz. Do you think I can just copy this one? ...eh, no,
will not fly, there's no SPITZ_GPIO_USB_PULLUP.

								Pavel
-- 
Thanks, Sharp!
