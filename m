Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKKDXd>; Fri, 10 Nov 2000 22:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbQKKDXX>; Fri, 10 Nov 2000 22:23:23 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:31749 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S129097AbQKKDXO>; Fri, 10 Nov 2000 22:23:14 -0500
Message-ID: <3A0CBD16.5A07D189@alacritech.com>
Date: Fri, 10 Nov 2000 19:29:26 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
CC: Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <200011110012.TAA22015@tsx-prime.MIT.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" wrote:
> 
>    Date: Fri, 10 Nov 2000 10:36:31 -0800
>    From: "Matt D. Robinson" <yakker@alacritech.com>
> 
>    As soon as I finish writing raw write disk routines (not using kiobufs),
>    we can _maybe_ get LKCD accepted one of these days, especially now that we
>    don't have to build 'lcrash' against a kernel revision.  I'm in the
>    middle of putting together raw IDE functions now -- see LKCD mailing
>    list for details if you're curious.
> 
> Great!  Are you thinking about putting the crash dumper and the raw
> write disk routines in a separate text section, so they can be located
> in pages which are write-protected from accidental modification in case
> some kernel code goes wild?  (Who me?  Paranoid?  :-)
> 
>                                                 - Ted

We're planning to isolate the write functions as much as possible.
In the past, we've been bitten by this whole concept of Linux "raw I/O".
When I was at SGI, we were able to write to a block device directly
through low-level driver functions that weren't inhibited by any
locking, and that was after shutting down all processors and any
other outstanding interrupts.  For Linux, I had given up and stuck
with the raw I/O interpretation of kiobufs, which is just flat out
wrong to do for dumping purposes.  Secondly, as Linus said to me a
few weeks ago, he doesn't trust the current disk drivers to be able
to reliably dump when a crash occurs.  Don't even ask me to go into
all the reasons kiobufs are wrong for crash dumping.  Just read
the code -- it'll be obvious enough.

So I guess after a few months/years, we're finally at a point where
we're saying, "Okay, forget all this, let's do this the right way,
so we don't have these problems anymore."  We're removing lcrash from
the kernel, putting it into its own RPM, and adding patches to the
kernel for LKCD that build in crash dump functionality and make a new
"Kernsyms" file so that we can dynamically read the symbol table of
major parts of the kernel and give you memory dumps, stack traces,
and even dump out entire structures dynamically.  Then we'll have
the right crash dump mechanism for everyone.

It's time to get RAS moving for Linux.  GKHI and LKCD are the first
steps to get us there (IMHO).

--Matt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
