Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131640AbRBEUfU>; Mon, 5 Feb 2001 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRBEUfK>; Mon, 5 Feb 2001 15:35:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30985 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131640AbRBEUe4>;
	Mon, 5 Feb 2001 15:34:56 -0500
Message-ID: <3A7F0E6C.D5ECA790@mandrakesoft.com>
Date: Mon, 05 Feb 2001 15:34:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rui.sousa@conexant.com
CC: linux-kernel@vger.kernel.org, Matthew Harrell <mharrell@bittwiddlers.com>
Subject: Re: 2.4.{1,2pre1} oops in via82cxxx_audio (?)
In-Reply-To: <OF9056ECFB.0D139AF2-ONC12569EA.006E4DDA@conexant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rui.sousa@conexant.com wrote:
> On 05/02/01 20:55 Jeff Garzik wrote:
> > The attached patch, sent to Matthew privately, apparently has fixed his
> > problem.  Right now it looks like an out-of-band interrupt...   The
> > interrupt is enabled via request_irq, and its shared so the interrupt
> > handler will be called.  However the channel isn't active so the SG
> > table hasn't been allocated yet.
> 
> But your interrupt status register should indicate that it wasn't the
> sound device that generated the interrupt...

Agreed -- iobase is uninitalized, I believe.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
