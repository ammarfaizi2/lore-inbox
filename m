Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbQL2LBv>; Fri, 29 Dec 2000 06:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbQL2LBl>; Fri, 29 Dec 2000 06:01:41 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:19986 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S131031AbQL2LB2>; Fri, 29 Dec 2000 06:01:28 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Jakub Jelinek <jakub@redhat.com>
Date: Fri, 29 Dec 2000 11:30:53 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: i386: gcc & asm(): wrong constraint for "mull"
CC: linux-kernel@vger.kernel.org
Message-ID: <3A4C75E2.16376.2867C7@localhost>
In-Reply-To: <20001229051730.K1120@devserv.devel.redhat.com>
In-Reply-To: <3A4C6D64.17348.73812@localhost>; from Ulrich.Windl@rz.uni-regensburg.de on Fri, Dec 29, 2000 at 10:54:38AM +0100
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Dec 2000, at 5:17, Jakub Jelinek wrote:

> On Fri, Dec 29, 2000 at 10:54:38AM +0100, Ulrich Windl wrote:
> > Hello,
> > 
> > I noticed (with some inspiration from Andy Kleen) that some asm() 
> > instructions for the ia32 use the "g" constraint for "mull", where my 
> > Intel 386 Assembly Language Manual suggests the "MUL" instruction needs 
> > an r/m operand. So I guess the correct constraint is "rm" in gcc, and 
> > not "g". That change identical assembly output for gcc-2.95.2, but some 
> > gcc-2.96.x will try a multiplication with an immediate (constant) 
> > operand for the "g" constarint, and the as will choke on that.
> > (Redhat 7.0 ships such a version of gcc).
> 
> gcc 2.95.2 md.texi sais:
> @cindex @samp{g} in constraint
> @item @samp{g}
> Any register, memory or immediate integer operand is allowed, except for
> registers that are not general registers.
> 
> (2.95.2 was chosen to make it clear it is not something new in gcc).
> That means gcc is really free to choose which of register, memory or
> immediate it puts in and the fact that some gcc version choose one and
> others choose other is perfectly correct.
> Fix the constraints and be happy (at least during the upcoming millenium) :)

Oh, if it wasn't clear: It's what I wanted to say. As I don't have a 
patch ready for that, maybe start at arch/i386/kernel/time.c; there are 
at least two of these "mull" instructions.

Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
