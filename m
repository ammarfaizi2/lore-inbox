Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278686AbRJSWhN>; Fri, 19 Oct 2001 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278688AbRJSWhD>; Fri, 19 Oct 2001 18:37:03 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:11538 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278686AbRJSWgu>; Fri, 19 Oct 2001 18:36:50 -0400
Message-ID: <3BD0AA3A.D3C61F0D@zip.com.au>
Date: Fri, 19 Oct 2001 15:33:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>
Subject: Re: [patch] ip autoconfig for PCMCIA NICs
In-Reply-To: <3BD092A6.26A1CFE9@zip.com.au>,
		<3BD092A6.26A1CFE9@zip.com.au> <29471.1003530166@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> akpm@zip.com.au said:
> >  Also, yenta_open() currently defers device initialisation to keventd,
> > so there is a good chance that cardbus init hasn't completed by the
> > time we hit ip autoconf, so the yenta_open_bh functionality is made
> > synchronous.
> 
> That was async at Linus' request - if we register the irq early, some
> boards die in an interrupt storm. Linux is currently fairly crap at
> noticing and recovering from interrupt storms.
> 

So any change in this area is untestable in the 2.4 context.  Sigh.

But how can the current code prevent IRQ problems?  AFAICT it just
delays the yenta_open_bh() operations by a short-but-random time
interval.

Should the IRQ be registered _after_ the call to cardbus_register()
when, presumably, the hardware is set up and has negated the IRQ
signal?


-
