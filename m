Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRAKEGe>; Wed, 10 Jan 2001 23:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbRAKEGP>; Wed, 10 Jan 2001 23:06:15 -0500
Received: from marine.sonic.net ([208.201.224.37]:15184 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129831AbRAKEGK>;
	Wed, 10 Jan 2001 23:06:10 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010110200550.A12593@sonic.net>
Date: Wed, 10 Jan 2001 20:05:50 -0800
From: David Hinds <dhinds@sonic.net>
To: Thiago Rondon <maluco@mileniumnet.com.br>, dahinds@users.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/pcmcia/cs.c
In-Reply-To: <Pine.LNX.4.21.0101101622210.4170-100000@freak.mileniumnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0101101622210.4170-100000@freak.mileniumnet.com.br>; from Thiago Rondon on Wed, Jan 10, 2001 at 04:23:14PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 04:23:14PM -0200, Thiago Rondon wrote:
> 
> Check kmalloc().
> 
> -Thiago Rondon
> 
> --- linux-2.4.0-ac5/drivers/pcmcia/cs.c	Fri Dec 29 20:35:47 2000
> +++ linux-2.4.0-ac5.maluco/drivers/pcmcia/cs.c	Wed Jan 10 16:18:11 2001
> @@ -1458,6 +1458,8 @@
>  	    s->functions = 1;
>  	s->config = kmalloc(sizeof(config_t) * s->functions,
>  			    GFP_KERNEL);
> +	if (!s->config) 
> +		return CS_OUT_OF_RESOURCE;
>  	memset(s->config, 0, sizeof(config_t) * s->functions);
>      }

This is not a satisfactory fix; if that kmalloc ever fails, you also
need to back out various things that were done higher up.  You can't
bail out at this spot.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
