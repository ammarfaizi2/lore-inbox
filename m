Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbQL2KsT>; Fri, 29 Dec 2000 05:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbQL2KsJ>; Fri, 29 Dec 2000 05:48:09 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:44817 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130993AbQL2Kr6>; Fri, 29 Dec 2000 05:47:58 -0500
Date: Fri, 29 Dec 2000 05:17:30 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386: gcc & asm(): wrong constraint for "mull"
Message-ID: <20001229051730.K1120@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <3A4C6D64.17348.73812@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4C6D64.17348.73812@localhost>; from Ulrich.Windl@rz.uni-regensburg.de on Fri, Dec 29, 2000 at 10:54:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 10:54:38AM +0100, Ulrich Windl wrote:
> Hello,
> 
> I noticed (with some inspiration from Andy Kleen) that some asm() 
> instructions for the ia32 use the "g" constraint for "mull", where my 
> Intel 386 Assembly Language Manual suggests the "MUL" instruction needs 
> an r/m operand. So I guess the correct constraint is "rm" in gcc, and 
> not "g". That change identical assembly output for gcc-2.95.2, but some 
> gcc-2.96.x will try a multiplication with an immediate (constant) 
> operand for the "g" constarint, and the as will choke on that.
> (Redhat 7.0 ships such a version of gcc).

gcc 2.95.2 md.texi sais:
@cindex @samp{g} in constraint
@item @samp{g}
Any register, memory or immediate integer operand is allowed, except for
registers that are not general registers.

(2.95.2 was chosen to make it clear it is not something new in gcc).
That means gcc is really free to choose which of register, memory or
immediate it puts in and the fact that some gcc version choose one and
others choose other is perfectly correct.
Fix the constraints and be happy (at least during the upcoming millenium) :)

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
