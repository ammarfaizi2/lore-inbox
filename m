Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbQKPAnj>; Wed, 15 Nov 2000 19:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbQKPAn3>; Wed, 15 Nov 2000 19:43:29 -0500
Received: from u-6.karlsruhe.ipdial.viaginterkom.de ([62.180.20.6]:48133 "EHLO
	u-6.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org with ESMTP
	id <S129524AbQKPAnL>; Wed, 15 Nov 2000 19:43:11 -0500
Date: Wed, 15 Nov 2000 10:38:15 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Jean Wolter <jean.wolter@inf.tu-dresden.de>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
Message-ID: <20001115103815.K927@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10011111844080.3611-100000@penguin.transmeta.com> <Pine.GSO.4.21.0011112207230.24250-100000@weyl.math.psu.edu> <20001113175017.B1820@twiddle.net> <86bsvizza3.fsf@kurt.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <86bsvizza3.fsf@kurt.inf.tu-dresden.de>; from jean.wolter@inf.tu-dresden.de on Tue, Nov 14, 2000 at 10:19:32AM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 10:19:32AM +0100, Jean Wolter wrote:

> > > OTOH, the value is used only by Alt-SysRq-T, so... Hell knows.
> > 
> > No, it's also used by 'ps -l'.  See wchan.
> 
> ps -l uses get_wchan() (an architecture specific function from
> arch/*/kernel/process.c) to get the return address from
> schedule(). And now thread_saved_pc() seems to do the same (at least
> on x86). Is there any reason to have two architecture specific
> functions doing the same or do I miss something?
> 
> Jean
> 
> PS: Architectures other then x86 use thread_saved_pc() to implement
> get_wchan(). If the debug output of Alt-SysRq-T is supposed to show
> the waiting channel we should use get_wchan() instead of thread_saved_pc().

Probably historic reasons, it's been that way as long as I can think back.
Yet the use of thread_saved_pc() in kernel/sched.c should imho be considered
a buglet and be replaced by get_wchan to get more meaningful debugging
information.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
