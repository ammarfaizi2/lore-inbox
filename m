Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVKDQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVKDQJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVKDQJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:09:33 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:32606 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751012AbVKDQJc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:09:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t+MIBXPavpYSTpVW3tHH5G6N7xJyIrEriQy1yGPqWwyK1g2gBxZD+8jsrZeYV93Tja6nr3dXOxexUKo3jnBBp7OP5gS7mK6sQr4Oe4GPgv3T9LUXvwO3oC9qb86fwQ81dOoa5oLVJGAJ6N4+Ya7kDfEk4VBZGoSz3elP/Ul+up0=
Message-ID: <d120d5000511040809m745f88a2j4a84715db3e3f01f@mail.gmail.com>
Date: Fri, 4 Nov 2005 11:09:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <436B83D9.8@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436B2819.4090909@drzeus.cx>
	 <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
	 <436B7B46.6060205@drzeus.cx>
	 <d120d5000511040727x7d433e08jeb8937cb2e48249a@mail.gmail.com>
	 <436B83D9.8@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Dmitry Torokhov wrote:
> > On 11/4/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> >
> >> Dmitry Torokhov wrote:
> >>
> >>> Hmm, would'nt presence of such device stop suspend process? It will
> >>> cause pnp_bus_resume to fail too. Perhaps returning 0 in this case is
> >>> better.
> >>>
> >>>
> >>>
> >> The problem is that this code is also visited from pnp_activate_dev() &
> >> co where this return value is needed. For pnp_stop_dev() the same check
> >> (pnp_can_disable()) is performed in the suspend routine to avoid that
> >> particular problem. For resume my assumption was that a device that
> >> doesn't support activation will not have a driver attached to it.
> >> Perhaps this is wrong?
> >>
> >>
> >
> > i8042 registers drivers for keyboard and AUX ports to gather
> > information whether the ports are present and what IRQ and IO ports
> > shoudl be used to access them. And I have seen a few boxes that do not
> > alloe [de]activate these devices.
> >
> >
>
> But the activation is performed by the PNP layer when the driver is
> matched with a driver. So the driver isn't really responsible for the
> activation. It can prevent activation through
> PNP_DRIVER_RES_DO_NOT_CHANGE though, but that flag is also checked in
> the suspend routines.
>

You lost me... We have a scenario when a PNP driver is bound to a PNP
device that does not support deactivation. Looking at the proposed PNP
bus suspend code presence of such device will cause suspend process to
fail. Are you saying this is what you want?

--
Dmitry
