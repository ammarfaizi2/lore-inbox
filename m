Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUL2SzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUL2SzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUL2SzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 13:55:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:33986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261395AbUL2Sy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 13:54:58 -0500
Date: Wed, 29 Dec 2004 10:53:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Hearn <mh@codeweavers.com>
cc: Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Jesse Allen <the3dfxdude@gmail.com>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <1104332559.3393.16.camel@littlegreen>
Message-ID: <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <419E42B3.8070901@wanadoo.fr>  <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
  <419E4A76.8020909@wanadoo.fr>  <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
  <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org> 
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>  <20041120214915.GA6100@tesore.ph.cox.net>
 <41A251A6.2030205@wanadoo.fr>  <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
  <1101161953.13273.7.camel@littlegreen>  <1104286459.7640.54.camel@gamecube.scs.ch>
 <1104332559.3393.16.camel@littlegreen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Dec 2004, Mike Hearn wrote:
> 
> I can't see if he CCd anybody from the archives but Jesse Allen posted a
> nice analysis of the remaining problem here:
> 
> http://www.winehq.org/hypermail/wine-devel/2004/12/0691.html

Ok, I don't remember the context from the Wine lists (and it's not clear
from the older emails I was cc'd on), so the "#3 signal.c" change
description is a bit too vague. Jesse, willing to just point to the exact
diff that you need to make Warcraft work for you (and then maybe Thomas
Sailer can verify whether that part is indeed the one that causes him
problems).

The code in question now does

        /*
         * Iff TF was set because the program is being single-stepped by a
         * debugger, don't save that information on the signal stack.. We
         * don't want debugging to change state.
         */
        eflags = regs->eflags;
        if (current->ptrace & PT_DTRACE)
                eflags &= ~TF_MASK;
        err |= __put_user(eflags, &sc->eflags);

and I guess it originally never cleared it. True?

So does removing the conditional TF clear make everything work again?

		Linus
