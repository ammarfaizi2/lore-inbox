Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUJTSh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUJTSh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJTShw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:37:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57765 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269010AbUJTSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:35:24 -0400
Date: Wed, 20 Oct 2004 19:15:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Mikael Starvik <mikael.starvik@axis.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9 PageAnon bug
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66818F59B@exmail1.se.axis.com>
Message-ID: <Pine.LNX.4.44.0410201903060.9436-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Mikael Starvik wrote:

> >Ah, sorry for messing CRIS up, I was unaware of that.
> 
> Well, it's kind of odd nowadays to have the freedom of arbitrary alignment. 
> 
> >I don't think that's ugly, and the comment is good.
> >It only actually needs "aligned(2)", would that be better?
> 
> Yes, aligned(2) is enough.
> 
> >But what does "aligned(2)" or "aligned(4)" do on 64-bit machines -
> >any danger of it aligning stupidly?  I think not, but know little.
> 
> Same here, we need input from the 64-bit world (or make it aligned(8)).
> 
> >>Another possible patch would be to move i_data above i_bytes and i_sock.
> >Really?  Precarious, I think you'd still need to insist on alignment.
> 
> I agree that there may be compilers out there that actually pads the
> structure to make the members unaligned. So you are correct, aligned()
> should be used to be safe (until memory allocation routines start to return
> unaligned addresses).
> 
> Will you send this upstream to Andrew?

Not without confirmation from people who know more about
__attribute__((aligned(N))) than we do.  I notice init.h has an
		__attribute__((aligned((sizeof(long)))))
which perhaps would be better (though going the other way than from 4 to 2).

And would it be better on the declaration of struct address_space itself,
than on the struct address_space i_data?

If nobody chimes in to help us, I'll ping a few people in a day or two:
for now use what works for you.

Hugh

