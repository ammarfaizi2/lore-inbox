Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWJFQVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWJFQVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJFQVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:21:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:52529 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932435AbWJFQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:21:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GjWu5A3n+pzeJg2nOnC2PyzE9rcA9rYCeBqtKwB2ou8l389sSjTfV7RSyWhR76m90zTKZjR6unYTXZoIgUTgr0R1TVB9qAJMWlfvASasT/nR9NU9Vv5m8gQG/HvNITuhCKBYSCm/l7+4fsJLFF6AvLL4V82Y1Oicf7UnQjXwvoQ=
Message-ID: <d120d5000610060921q493a3f58n45285e6dcc037156@mail.gmail.com>
Date: Fri, 6 Oct 2006 12:21:27 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than passing to IRQ handlers
Cc: "Jeff Garzik" <jeff@garzik.org>, "David Howells" <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Greg KH" <greg@kroah.com>, "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <4525A8D8.9050504@garzik.org>
	 <1160133932.1607.68.camel@localhost.localdomain>
	 <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu>
	 <45263D9C.9030200@garzik.org> <452673AC.1080602@garzik.org>
	 <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/06, Linus Torvalds <torvalds@osdl.org> wrote:

> In contrast, the irq argument itself is really no different from the
> cookie we pass in on registration - it's just passing it back to the
> driver that requested the thing. So unlike "regs", there's not really
> anything strange about it, and there's nothing really "wrong" with having
> it there.
>
> So I'm not at all as convinced about this one.

But drivers rarely care about exact IRQ that caused their interrupt
routines to be called. I looked at some of them and they normally use
it just to print warnings which is not critical (and data can still be
retrieved form elsewhere). And without it the only argument can very
nicely be passed via a register (if regparm is allowed).

Drivers that truly need to know IRQ can have it added to dev_id cookie
and use separate dev_ids.

-- 
Dmitry
