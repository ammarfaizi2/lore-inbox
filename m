Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbREYA4u>; Thu, 24 May 2001 20:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263474AbREYA4k>; Thu, 24 May 2001 20:56:40 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64271 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263473AbREYA4Z>;
	Thu, 24 May 2001 20:56:25 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15117.44426.899390.29151@tango.paulus.ozlabs.org>
Date: Fri, 25 May 2001 10:55:38 +1000 (EST)
To: Jeff Mcadams <jeffm@iglou.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SyncPPP Generic PPP merge
In-Reply-To: <20010524185333.B7667@iglou.com>
In-Reply-To: <002501c0e48f$ffed1e40$0c00a8c0@diemos>
	<E1533Ra-0005hC-00@the-village.bc.nu>
	<20010524185333.B7667@iglou.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mcadams writes:

> Indeed.  And let me just throw out another thought.  A clean abstraction
> of the various portions of the PPP functionality is beneficial in other
> ways.  My personal pet project being to add L2TP support to the kernel
> eventually.  A good abstraction of the framing capabilities and basic
> PPP processing would be rather useful in that project.

That is exactly what ppp_generic.c is intended to do - it abstracts
out the framing and encapsulation and low-level transport of PPP
frames into ppp "channels" (see for example ppp_async.c,
ppp_synctty.c) while ppp_generic.c does the basic PPP processing
(compression, multilink, handling the network interface device etc.).

You should be able to write an L2TP channel to work with ppp_generic -
all your code would need to know about is how to take a PPP frame and
encapsulate and send it, and how to receive and decapsulate PPP
frames.

[Note to myself: send in a Documentation/ppp_generic.txt which
describes the interface between ppp_generic.c and the channels.]

> I would agree that such a project would be 2.5 material.

Do it today if you like, I can't see that adding a new PPP channel
could break anything else, it would be like adding a new driver.

Paul.
