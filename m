Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284989AbRLQDkX>; Sun, 16 Dec 2001 22:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284997AbRLQDkE>; Sun, 16 Dec 2001 22:40:04 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:14609 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284989AbRLQDkB>;
	Sun, 16 Dec 2001 22:40:01 -0500
Date: Mon, 17 Dec 2001 14:24:00 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: David Hinds <dhinds@sonic.net>
Cc: Ian Morgan <imorgan@webcon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: in-kernel pcmcia oopsing in SMP
Message-ID: <20011217142400.L30975@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	David Hinds <dhinds@sonic.net>, Ian Morgan <imorgan@webcon.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011201120541.B28295@sonic.net> <Pine.LNX.4.40.0112011513041.2329-100000@light.webcon.net> <20011201124630.A30249@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201124630.A30249@sonic.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 12:46:30PM -0800, David Hinds wrote:
> On Sat, Dec 01, 2001 at 03:27:24PM -0500, Ian Morgan wrote:
> > 
> > > I don't know how to interpret your oops report; you should probably
> > > also forward the bug to David Gibson, hermes@gibson.dropbear.id.au,
> > > since he is the orinoco maintainer.
> > 
> > Well, Gibson's the one who suggested the broblem was with the pcmcia system,
> > and not the orinoco driver! Hmm.... can you say runaround?

Look, I'm not paid to do tech support for you, so there is nothing for
me to gain in trying to give you the runaround.  The orinoco driver is
designed to make hard hangs very unlikely, even at the expense of a
greater chance of the driver operation falling over, so that was by
best initial guess at the problem - albeit possibly a hurried and
inaccurate one (see below).

> It pretty much can't be a PCMCIA subsystem bug.  The basic PCMCIA code
> handles card identification and configuration of the socket; however,
> for almost all cards, the PCMCIA subsystem is completely out of the
> loop during normal card operation.  No PCMCIA code outside of the
> orinoco driver itself will ever be executed.

Hmm... yes, I suppose so.  How odd.

> Your oops, in tasklet code, sounds to me like a locking bug in the
> driver code for managing the transmit stack vs. interrupt handling.
> Have there been reports of the driver working well on SMP boxes?

Well, one of the main features of the driver is that the Tx path and
the interupt handler (Rx path) are permitted to run concurrently.
This is an issue even on UP (although not as complex), since the Rx
patch can interrupt the Tx path.  I believe there has been at least
some successful operation on SMP machines, but unfortunately I don't
know any details.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

