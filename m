Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTESGHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 02:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTESGHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 02:07:04 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:51668 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id S262351AbTESGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 02:07:03 -0400
Date: Mon, 19 May 2003 08:19:39 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030519061939.GB944@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030518163537.GZ8978@holomorphy.com> <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 07:24:17PM +0200, Peter T. Breuer wrote:
> "A month of sundays ago William Lee Irwin III wrote:"
> > At some point in the past, Peter Breuer's attribution was removed from:
> > >> Here's a before-breakfast implementation of a recursive spinlock. That
> > >> is, the same thread can "take" the spinlock repeatedly. 
> > 
> > On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
> > > Why?
> > 
> > netconsole.
> 
> That's a problem looking for a solution!  No, the reason for wanting a
> recursive spinlock is that nonrecursive locks make programming harder.
> 
> Though I've got quite good at finding and removing deadlocks in my old
> age, there are still two popular ways that the rest of the world's
> prgrammers often shoot themselves in the foot with a spinlock:
> 
>    a) sleeping while holding the spinlock
>    b) taking the spinlock in a subroutine while you already have it
> 
> The first method leads to an early death if the spinlock is a popular
> one, as the only thread that can release it doesn't seem to be running,
> errr..
> 
> The second method is used by programmers who aren't aware that some
> obscure subroutine takes a spinlock, and who recklessly take a lock
> before calling a subroutine (the very thought sends shivers down my
> spine ...).  A popular scenario involves not /knowing/ that your routine
> is called by the kernel with some obscure lock already held, and then
> calling a subroutine that calls the same obscure lock.  The request
> function is one example, but that's hardly obscure (and in 2.5 the 
> situation has eased there!).
> 
> It's the case (b) that a recursive spinlock makes go away.

It thought we still have the spinlock debuging level 2 which DOES CHECK
THIS (seems noone knows about it - I had to fix a trivial error when
I used it in user-mode arch, but it worked well then). [check means it
gives backtrace]

> Hey, that's not bad for a small change! 50% of potential programming
> errors sent to the dustbin without ever being encountered.

They are errors. Appropriate response to errors is an OOPS.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
