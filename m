Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRAWM0b>; Tue, 23 Jan 2001 07:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbRAWM0W>; Tue, 23 Jan 2001 07:26:22 -0500
Received: from mail.zmailer.org ([194.252.70.162]:2567 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130230AbRAWM0C>;
	Tue, 23 Jan 2001 07:26:02 -0500
Date: Tue, 23 Jan 2001 14:25:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Ford <david@linux.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
Message-ID: <20010123142550.J25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com> <3A6D616F.63EB34A6@linux.com> <20010123125636.I25659@mea-ext.zmailer.org> <3A6D676C.2F6D5236@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A6D676C.2F6D5236@linux.com>; from david@linux.com on Tue, Jan 23, 2001 at 11:13:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 11:13:48AM +0000, David Ford wrote:
> > > The three cardbus cards are slightly different in numerous ways.  For
> > > them they normally fault with an APM event, an eject/insert cycle via
> > > software will reset hem and a link down/up won't fix it.  For the PCI
....
> > > The PCI cards are hard to get into this state, sometimes they'll run
> > > millions of packets for months on end before they'll burp.  Sometimes
> > > it'll happen three times a night.  The amount of traffic doesn't seem
> > > to matter, nor does the type of traffic.
> >
> >         Sounds like timing issue.
> 
> Hmm, should we class these as two similar but different bugs?  I suspect they
> are both timing but there is another stimulus operating differently.

  I think they are separate problems.
  The first is power-management suspend/resume issue, and possibly
  PCMCIA problem at software re-insert of card (which never was taken
  out *physically*).

  If I pull the cardbus card out, make sure the  "dhcpcd eth0" has
  died (e.g. I kill it), and re-insert the card, system is highly
  likely to work.

  It is just that if I suspend my laptop with card in, and wakeup it
  latter, there I encounter dead network card.


  Hangup/barfing on system which never suspends will never excercise
  suspend/resume codepaths, but may poke at wrong moment at some register,
  which causes card severe indigestion problems - rx/tx hangup.

  Sadly a "100% Compatible" usually means: "beware odd problems"

> -d

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
