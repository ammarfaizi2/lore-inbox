Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRE2BTB>; Mon, 28 May 2001 21:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261974AbRE2BSl>; Mon, 28 May 2001 21:18:41 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:61671 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261969AbRE2BSc>; Mon, 28 May 2001 21:18:32 -0400
Message-ID: <3B12F761.FE676BEF@uow.edu.au>
Date: Tue, 29 May 2001 11:12:01 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Kieu <haiquy@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.5-ac2 OOPs when run pppd ?
In-Reply-To: <3B125E62.1DD4712E@uow.edu.au>,
		<20010528084855.10604.qmail@web10402.mail.yahoo.com>
		<E154NQp-000386-00@the-village.bc.nu>
		<3B125E62.1DD4712E@uow.edu.au> <200105281821.f4SIL5000350@mobilix.atnf.CSIRO.AU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> How about having a helper function for interrupt handlers which queues
> characters to be sent to the console? kconsoled anyone? Blocking
> interrupts is quite distressing, so we need to be consoled ;-)

I don't think we need it, Richard.  These writes to tty
devices from interrupt context are coming from line
disciplines - n_hdlc, ppp, r3964, etc.

Now, while it may be amusing to see if you can successfully
negotiate a PPP session by typing raw LCP, there really isn't,
I believe, a useful reason for attaching one of these ldiscs
to the console tty.

Interrupt-context writes to the *console*, as opposed to
the console *tty* work just fine, of course.  printk.
