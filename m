Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbRG0Jfu>; Fri, 27 Jul 2001 05:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbRG0Jfk>; Fri, 27 Jul 2001 05:35:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14470 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267898AbRG0Jf3>;
	Fri, 27 Jul 2001 05:35:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.13760.734675.989919@pizda.ninka.net>
Date: Fri, 27 Jul 2001 02:34:56 -0700 (PDT)
To: kuznet@ms2.inr.ac.ru
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
In-Reply-To: <200107261746.VAA31697@ms2.inr.ac.ru>
In-Reply-To: <20010726002357.D32148@athlon.random>
	<200107261746.VAA31697@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


kuznet@ms2.inr.ac.ru writes:
 > So, is plain raising softirq and leaving it raised before return
 > to normal context not a bug? If so, then no problems.

Do you mean "user context" when you say normal?  Or just arbitrary
non-interrupt context.  In fact, to me, no specific execution context
stands out with description of "normal".  All of them are normal
:-))))

 > > after netif_rx.
 > 
 > But why not to do just local_bh_disable(); netif_rx(); local_bh_enable()?
 > Is this not right?

As Jeff mentioned, this is the cure we agreed to in earlier softirq
postings.

The reason I pushed to have netif_FOO use __cpu_raise_softirq() was
that I felt sick to my stomache when I saw a new whole function call
added to that spot.  It is one of the most imporant paths in packet
processing, and it runs regardless of protocol you use (well, except
perhaps AF_UNIX :-)))

Let us just fix the odd places that aren't calling things in the
correct environment.

Later,
David S. Miller
davem@redhat.com
