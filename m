Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291633AbSBAJYO>; Fri, 1 Feb 2002 04:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291629AbSBAJX0>; Fri, 1 Feb 2002 04:23:26 -0500
Received: from mail.sonytel.be ([193.74.243.200]:55208 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291624AbSBAJWi>;
	Fri, 1 Feb 2002 04:22:38 -0500
Date: Fri, 1 Feb 2002 10:18:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers III
In-Reply-To: <Pine.LNX.4.10.10201311614300.6830-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0202011014360.25104-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, James Simmons wrote:
> Okay. This patch should now work. Give it a try. Remember also the amiga
> joystick and mouse are alredy in the Dave Jones tree waiting to be tested
> :-)
> 
> diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c linux/drivers/input/keyboard/amikbd.c
> --- linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/input/keyboard/amikbd.c	Thu Jan 31 17:11:00 2002

> +static int __init amikbd_init(void)
> +{
> +	int i;
> +
> +	if (!AMIGAHW_PRESENT(AMI_KEYBOARD))
> +		return -EIO;

Please add

    if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
            return -EBUSY;

here (cfr. drivers/char/amikeyb.c).

> +static void __exit amikbd_exit(void)
> +{
> +	input_unregister_device(&amikbd_dev);
> +	free_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt);

And

    release_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100);

here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

