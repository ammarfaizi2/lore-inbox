Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUKWXWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUKWXWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKWXUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:20:16 -0500
Received: from mail.dif.dk ([193.138.115.101]:42207 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261636AbUKWXTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:19:12 -0500
Date: Wed, 24 Nov 2004 00:28:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <41A3C31E.5060007@ammasso.com>
Message-ID: <Pine.LNX.4.61.0411240024190.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org> <41A38BF1.9060207@ammasso.com>
 <Pine.LNX.4.61.0411240003300.3389@dragon.hygekrogen.localhost>
 <41A3C1AE.5060604@ammasso.com> <Pine.LNX.4.61.0411240016350.3389@dragon.hygekrogen.localhost>
 <41A3C31E.5060007@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Timur Tabi wrote:

> Jesper Juhl wrote:
> 
> > My understanding of it is that it was just an example of how code that
> > generated warnings about limited range of datatype could actually be
> > perfectly fine.
> 
> But if the example doesn't make any sense, then how does it prove the point?
> 
How about this then; let's say that pid_t can be either 16 or 32 bits, and 
for some reason you want to handle something special if the value is 
greater than 0xffffff (or some other arbitrary value between 0xffff and 
0xffffffff), obviously that can only happen in the cases where pid_t is 32 
bit and never when it is only 16 bit, so code like

int foo(pid_t a) {
	if (a > 0xffffff) {
		...
	}
}

will generate warnings when pid_t is only 16 bit, but not when it is 32 
bit, but the code will still do the correct thing in every case and is 
perfectly OK.

--
Jesper Juhl


