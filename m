Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267225AbUBSMW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267221AbUBSMW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:22:26 -0500
Received: from intra.cyclades.com ([64.186.161.6]:10643 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S267225AbUBSMWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:22:24 -0500
Date: Thu, 19 Feb 2004 10:14:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Silla Rizzoli <silla@netvalley.it>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
In-Reply-To: <200402191222.45709.silla@netvalley.it>
Message-ID: <Pine.LNX.4.58L.0402191011470.29796@logos.cnet>
References: <200402191222.45709.silla@netvalley.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Silla Rizzoli wrote:

> Hello!
> Inserting a PC Card in my laptop (IMB R40 2681) with kernel 2.4.25 results in
> the following message:
>
> Feb 19 11:10:16 [kernel] cs: socket d603e000 voltage interrogation timed out
>
> This sometimes happens with 2.6.x too, but issuing cardctl insert 0 usually
> solves the problem, however in this case it didn't. I tried to modify all the
> pcmcia_core module parameters but to no avail, the socket remained dead.
>
> Examining the sources I noticed that 2.4.25 introduced this three line check;
> I suppose that the socket state read returns a valid state and
> cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST) is not executed.
> Removing the check and executing the last line regardless fixes the problem.
> I am probably experiencing a hardware bug limited to my laptop, but I'm
> posting this small patch here just in case someone has the same problem.
>
> Regards,
> Silla Rizzoli
>
>
>
> --- ./drivers/pcmcia/yenta.c.orig       2004-02-19 11:44:29.000000000 +0100
> +++ ./drivers/pcmcia/yenta.c    2004-02-19 11:43:45.000000000 +0100
> @@ -676,9 +676,6 @@
>         exca_writeb(socket, I365_GENCTL, 0x00);
>
>         /* Redo card voltage interrogation */
> -       state = cb_readl(socket, CB_SOCKET_STATE);
> -       if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
> -                       CB_3VCARD | CB_XVCARD | CB_YVCARD)))
>
>         cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
>  }

Hi Silla,

Unfortunately this change fixes other problems (in Acer TravelMate laptops
for one I know, maybe others).

Someone needs to figure out a way for detection to work properly on both
setups.
