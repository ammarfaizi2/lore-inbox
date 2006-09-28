Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWI1Gtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWI1Gtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWI1Gtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:49:40 -0400
Received: from gw.goop.org ([64.81.55.164]:35506 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161044AbWI1Gtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:49:39 -0400
Message-ID: <451B708D.20505@goop.org>
Date: Wed, 27 Sep 2006 23:49:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org>
In-Reply-To: <20060927233509.f675c02d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> hm.  Bigger vmlinux, smaller .text.
>   

Yep.

> It means that we'll hit handle_BUG with that extra EIP pushed on the stack.
>  What does that do to the stack trace, and to the unwinder?
>   
Dunno.  I was hoping Andi would pop up with the appropriate CFI gunk, if 
necessary.  But the reason for making it a call was to make it as 
unwindable as possible.

> It'll also muck up the displayed EIP, not that that matters a lot (well, it
> might matter a bit if the BUG is in an inlined function).
>
> We could get the correct EIP by fishing it off the stack (and subtracting
> five from it?)
>   

Yes, that's possible.

> Or we could assume that BUG doesn't return (it doesn't) and make that call
> a jmp.  But then we'd really lose the EIP.

Right.  Or it could save the EIP along with the line and filename.

    J
