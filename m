Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBFTbz>; Tue, 6 Feb 2001 14:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRBFTbq>; Tue, 6 Feb 2001 14:31:46 -0500
Received: from colorfullife.com ([216.156.138.34]:43528 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129304AbRBFTbl>;
	Tue, 6 Feb 2001 14:31:41 -0500
Message-ID: <3A805121.E4D47C32@colorfullife.com>
Date: Tue, 06 Feb 2001 20:31:45 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jocelyn Mayer <jocelyn.mayer@netgem.com>, linux-kernel@vger.kernel.org
Subject: Re: FA-311 / Natsemi problems with 2.4.1
In-Reply-To: <3A80425C.8080506@netgem.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jocelyn Mayer wrote:
> 
> I'll send my patch for 2.4 kernel
> as soon as I have finished to clean it up !!!
>

A few points:

* set your tabs to 8, and indent by 8 characters.
* Nastemi_auto_negociate: remove the 'static' variable - what if someone
has multiple cards installed?
* You cannot wait for for more than a few dozend microseconds in an
hardware interrupt handle, and a few hundred microseconds in a bottom
half handler (e.g a timer)
Probably the autonegotiation takes longer - add a timer that calls you
back after 50 milliseconds, and return.

And are you sure that a full reset is required for a simple link change?

Most other drivers are written the other way around:
tx_timeout() performs the full reset if the transmitter is hung for > 2
seconds, and link_change only changes the chip configuration.


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
