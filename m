Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269264AbTCBSPb>; Sun, 2 Mar 2003 13:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269263AbTCBSPb>; Sun, 2 Mar 2003 13:15:31 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27410 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269264AbTCBSP3>; Sun, 2 Mar 2003 13:15:29 -0500
Date: Sun, 2 Mar 2003 19:25:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Ulrich Drepper <drepper@redhat.com>
cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
In-Reply-To: <3E6247F7.8060301@redhat.com>
Message-ID: <Pine.LNX.4.44.0303021919180.32518-100000@serv>
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Mar 2003, Ulrich Drepper wrote:

> > -	if (!urb->status & !acm->throttle)  {
> > +	if (!urb->status && !acm->throttle)  {
> 
> [...]
> 
> Observe the extra 'jne' and the fact that the value of 'throttle'
> element cannot be loaded until after the conditional jump.   Not even
> out of order execution can arrange that.

But speculative execution can arrange that (providing the cpu predicted 
the jump target correctly).

> To summarize, I'd probably not be amused if you would change any of my
> code which takes advantage of such programming finess.

If that was really intentional, I would assume to see something like this:

	if (!(urb->status | acm->throttle)) {

bye, Roman

