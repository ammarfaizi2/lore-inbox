Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSJARdg>; Tue, 1 Oct 2002 13:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSJARcW>; Tue, 1 Oct 2002 13:32:22 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:48252 "EHLO
	elipse.com.br") by vger.kernel.org with ESMTP id <S262170AbSJARbT>;
	Tue, 1 Oct 2002 13:31:19 -0400
Message-ID: <035401c26971$9dff4b50$1c00a8c0@elipse.com.br>
Reply-To: "Felipe W Damasio" <felipewd@elipse.com.br>
From: "Felipe W Damasio" <felipewd@elipse.com.br>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Kent Yoder" <key@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <tsbogend@alpha.franken.de>
References: <Pine.LNX.4.44.0210011129330.14607-100000@ennui.austin.ibm.com> <3D99D923.5080200@pobox.com>
Subject: Re: [PATCH] pcnet32 cable status check
Date: Tue, 1 Oct 2002 14:40:22 -0300
Organization: Elipse Software
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 01 Oct 2002 17:40:22.0281 (UTC) FILETIME=[9DFFE790:01C26971]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Kent Yoder" <key@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>; <tsbogend@alpha.franken.de>
Sent: Tuesday, October 01, 2002 2:19 PM
Subject: Re: [PATCH] pcnet32 cable status check


> Kent Yoder wrote:
> > +static void pcnet32_watchdog(struct net_device *dev)
> > +{
> > +    struct pcnet32_private *lp = dev->priv;
> > +
> > +    /* Print the link status if it has changed */
> > +    if (lp->mii)
> > + mii_check_media (&lp->mii_if, 1, 0);
> > +
> > +    mod_timer (&(lp->watchdog_timer), PCNET32_WATCHDOG_TIMEOUT);
> > +}
>
>
> Looks good ;-)
>
> One small thing -- since you appear to test all cases for (lp->mii)
> before calling mod_timer, I don't think you need to test lp->mii inside
> the timer...
>
> As Felipe mentioned, using the link interrupt instead of a timer is
> preferred -- but my own preference would be to apply your patch with the
> small remove-lp->mii-check fixup, and then investigate the support of
> link interrupts.  The reasoning is that, pcnet32 covers a ton of chips,
> and not all may support a link interrupt.

    Sounds nice.

    When identified which chips support Link Change, a bit indicating so
could be add to the capabilities of the NIC so we could choose link
interrupt instead of timer when appropriate.

    I'll try and investigate some chips soon and let you know.

Felipe

