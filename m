Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286153AbRLJTNJ>; Mon, 10 Dec 2001 14:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286360AbRLJTNA>; Mon, 10 Dec 2001 14:13:00 -0500
Received: from borderworlds.dk ([193.162.142.101]:25604 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S286359AbRLJTMq>; Mon, 10 Dec 2001 14:12:46 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in moxa driver
In-Reply-To: <m3zo4rm05v.fsf@borg.borderworlds.dk>
	<20011210194003.1cb9f54a.skraw@ithnet.com>
From: Christian Laursen <xi@borderworlds.dk>
Date: 10 Dec 2001 20:12:35 +0100
In-Reply-To: <20011210194003.1cb9f54a.skraw@ithnet.com>
Message-ID: <m3pu5mnb30.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> On 10 Dec 2001 18:53:48 +0100
> Christian Laursen <xi@borderworlds.dk> wrote:
> 
> > I have a problem when trying to use two of the serial cards known as
> > MOXA C104H/PCI.
> > 
> > When only using one, everything works like a charm, but when
> > an attempt is made to access a serial port on the second card,
> > I get a NULL pointer dereference.
> > 
> > 
> > This is the relevant output from dmesg:
> > 
> > MOXA Smartio family driver version 1.2
> > Tty devices major number = 174, callout devices major number = 175
> > Found MOXA C104H/PCI series board(BusNo=0,DevNo=10)
> > 
> > 
> > The relevant stuff from /proc/pci:
> > 
> >   Bus  0, device  10, function  0:
> >     Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (rev 2).
> >       IRQ 10.
> >       I/O at 0xa800 [0xa87f].
> >       I/O at 0xa400 [0xa43f].
> >       I/O at 0xa000 [0xa00f].
> >   Bus  0, device  11, function  0:
> >     Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (#2) (rev 2).
> >       IRQ 11.
> >       I/O at 0x9800 [0x987f].
> >       I/O at 0x9400 [0x943f].
> >       I/O at 0x9000 [0x900f].
> 
> Well there you have it: they didn't recognise the second board at
> all. The dmesg should show it, but does not.  Please try attached
> patch to mxser.c. I cannot test, I have no two cards (in fact I
> haven't a single one either ;-). If it works out tell me and send
> patch to support@moxa.com.tw with regards from me :-)

Well, now it finds both the cards. :)

MOXA Smartio family driver version 1.2
Tty devices major number = 174, callout devices major number = 175
Found MOXA C104H/PCI series board(BusNo=0,DevNo=10)
Found MOXA C104H/PCI series board(BusNo=0,DevNo=11)

However, access to the second one still results in the oops. :-/

-- 
Best regards
    Christian Laursen
