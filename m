Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRJTVv7>; Sat, 20 Oct 2001 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274627AbRJTVvt>; Sat, 20 Oct 2001 17:51:49 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:25100 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274603AbRJTVvm>; Sat, 20 Oct 2001 17:51:42 -0400
Date: Sat, 20 Oct 2001 23:52:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Chip Salzenberg <chip@pobox.com>
Cc: jsimmons@transvirtual.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxconsole-dev@lists.sourceforge.net
Subject: Re: [PATCH] input-ps2: sprintf() params missing
Message-ID: <20011020235213.A28636@suse.cz>
In-Reply-To: <20011017202343.A5079@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017202343.A5079@perlsupport.com>; from chip@pobox.com on Wed, Oct 17, 2001 at 08:23:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 08:23:43PM -0700, Chip Salzenberg wrote:

> The recently advertised input-ps2 patch has a minor repeated bug, in
> that sprintf() calls are made without enough parameters.  I'm not sure
> what the right fix is, but the attached patch at least calls sprintf()
> correctly.
> -- 
> Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
>  "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech


The correct lines should look like this:

sprintf(atkbd->phys, "%s/input0", serio->phys);

It's in the CVS, anyway.

> 
> Index: drivers/char/atkbd.c
> --- drivers/char/atkbd.c.old	Wed Oct 17 13:36:43 2001
> +++ drivers/char/atkbd.c	Wed Oct 17 19:13:57 2001
> @@ -493,5 +493,5 @@
>  		sprintf(atkbd->name, "AT Set %d keyboard", atkbd->set);
>  
> -	sprintf(atkbd->phys, "%s/input0\n");
> +	sprintf(atkbd->phys, "/dev/serio%d", serio->number);
>  
>  	if (atkbd->set == 3)
> 
> Index: drivers/char/psmouse.c
> --- drivers/char/psmouse.c.old	Wed Oct 17 13:36:43 2001
> +++ drivers/char/psmouse.c	Wed Oct 17 19:14:11 2001
> @@ -609,5 +609,5 @@
>  	sprintf(psmouse->devname, "%s %s %s",
>  		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
> -	sprintf(psmouse->phys, "%s/input0\n");
> +	sprintf(psmouse->phys, "/dev/serio%d", serio->number);
>  
>  	psmouse->dev.name = psmouse->devname;
> 
> Index: drivers/char/xtkbd.c
> --- drivers/char/xtkbd.c.old	Wed Oct 17 13:36:43 2001
> +++ drivers/char/xtkbd.c	Wed Oct 17 19:14:07 2001
> @@ -115,5 +115,5 @@
>  	clear_bit(0, xtkbd->dev.keybit);
>  
> -	sprintf(xtkbd->phys, "%s/input0\n");
> +	sprintf(xtkbd->phys, "/dev/serio%d", serio->number);
>  
>  	xtkbd->dev.name = xtkbd_name;


-- 
Vojtech Pavlik
SuSE Labs
