Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279370AbRJWKzK>; Tue, 23 Oct 2001 06:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279362AbRJWKyu>; Tue, 23 Oct 2001 06:54:50 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:9891 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279363AbRJWKyi>; Tue, 23 Oct 2001 06:54:38 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Tue, 23 Oct 2001 12:54:49 +0200
Message-Id: <20011023105449.8455@smtp.adsl.oleane.com>
In-Reply-To: <E15vpU0-00045L-00@the-village.bc.nu>
In-Reply-To: <E15vpU0-00045L-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'd very much like this one to be two pass, with the second pass occuring
>after interrupts are disabled. There are some horrible cases to try and
>handle otherwise (like devices that like to jam the irq line high).
>
>Ditto on return from suspend where some devices also like to float the irq
>high as you take them over (eg USB on my Palmax). From comments Ben made
>ages back I believe ppc has similar issues if not worse

Well, the idea here was to disable them between the second and third
pass. Device that can completely suspend with interrupts enabled can
do it at the end of step 2, while more broken devices can do it at
step 3. It might be semantically more clear to actually consider step
2 as exclusively "block io & save state", in which case, breaking up
the "suspend" state into 2 separate states with and without interrupt
makes sense. We just didn't fell that was necessary.

Ben.


