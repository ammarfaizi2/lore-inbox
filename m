Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRH0UZk>; Mon, 27 Aug 2001 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268848AbRH0UZb>; Mon, 27 Aug 2001 16:25:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268856AbRH0UZR>; Mon, 27 Aug 2001 16:25:17 -0400
Subject: Re: DOS2linux
To: Bart.Vandewoestyne@pandora.be (Bart Vandewoestyne)
Date: Mon, 27 Aug 2001 21:28:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B8AAB3E.1EC121EA@pandora.be> from "Bart Vandewoestyne" at Aug 27, 2001 10:19:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bT0B-0004ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm... with 'writing cleanly' you mean that there should become things
> available like eisa_register_device() etc...?

Yeah

> > EISA slots are I/O mapped at 0x1000, 0x2000, 0x3000, 0x4000 -> 0x8000
> > The ID port is at base+0xc80
> > Configuration data follows at base+0xc84, 0xc88 ...
> 
> Yep, that was also what I figured out.
> 
> > I would assume the 320 byte buffer is providing this same data block, and
> > maybe more but I don't know the details.
> 
> That is also what I think, but the problem is that I don't know at
> which offset to look for that data...
> If you look at the code:
> 
> Would it help if i told you that itconf and dmachd are defined as (see
> http://mc303.ulyssis.org/heim/downloads/DISCINC.H )
> 
> #define itconf                0xb2
> #define dmachd                0xc0
> 
> So if my EISA board is at 0x1000, i should be able to read these
> values from 0x1000+0xb2 and 0x1000+0xc0 ???  And if 'yes', any idea
> about how to read them? (byte, word, long...? My guess would be as a
> byte, but I'm not sure...)
> 

Wild guess. Try iobase + 0xC80 to check if the card is in that slot, then
check inb(iobase+0xC80+0xb2) and see if that gives sane answers
