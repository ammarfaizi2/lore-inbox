Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284248AbRLAUrB>; Sat, 1 Dec 2001 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284247AbRLAUqv>; Sat, 1 Dec 2001 15:46:51 -0500
Received: from marine.sonic.net ([208.201.224.37]:34583 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S284244AbRLAUqo>;
	Sat, 1 Dec 2001 15:46:44 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Sat, 1 Dec 2001 12:46:30 -0800
From: David Hinds <dhinds@sonic.net>
To: Ian Morgan <imorgan@webcon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hermes@gibson.dropbear.id.au
Subject: Re: in-kernel pcmcia oopsing in SMP
Message-ID: <20011201124630.A30249@sonic.net>
In-Reply-To: <20011201120541.B28295@sonic.net> <Pine.LNX.4.40.0112011513041.2329-100000@light.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112011513041.2329-100000@light.webcon.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 03:27:24PM -0500, Ian Morgan wrote:
> 
> > I don't know how to interpret your oops report; you should probably
> > also forward the bug to David Gibson, hermes@gibson.dropbear.id.au,
> > since he is the orinoco maintainer.
> 
> Well, Gibson's the one who suggested the broblem was with the pcmcia system,
> and not the orinoco driver! Hmm.... can you say runaround?

It pretty much can't be a PCMCIA subsystem bug.  The basic PCMCIA code
handles card identification and configuration of the socket; however,
for almost all cards, the PCMCIA subsystem is completely out of the
loop during normal card operation.  No PCMCIA code outside of the
orinoco driver itself will ever be executed.

Your oops, in tasklet code, sounds to me like a locking bug in the
driver code for managing the transmit stack vs. interrupt handling.
Have there been reports of the driver working well on SMP boxes?

-- Dave
