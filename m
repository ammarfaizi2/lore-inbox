Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSLFVtK>; Fri, 6 Dec 2002 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbSLFVtK>; Fri, 6 Dec 2002 16:49:10 -0500
Received: from mail.ccur.com ([208.248.32.212]:58898 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S262602AbSLFVtK>;
	Fri, 6 Dec 2002 16:49:10 -0500
Message-ID: <3DF11D16.289456B2@ccur.com>
Date: Fri, 06 Dec 2002 16:56:38 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212061307310.3830-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 6 Dec 2002, george anzinger wrote:
> >
> > I have not looked at your code yet, but I am concerned that
> > the restart may not be able to get to the original
> > parameters.
> 
> The way the new system call restarting is done, it never looks at the old
> parameters. They don't even _exist_ for the restarted call (well, they do,
> but the restart function can't actually get at them). So it is up to the
> original interrupted call to save off anything it needs saving off (and it
> get sthe "restart_block" structure to do that saving in. Right now that's
> just three words, but we can expand it if necessary).
> 
      
Hi Linus,

I know it would be a few extra lines of assembly code but it would be
nice if the restart routine had the original arguments.  Would it be too
ugly to do something like:

sys_restart_syscall:
	GET_THREAD_INFO(%eax)
	jmp	TI_RESTART_BLOCK(%eax)

I'm having second thoughts about even sending this.  Its just that I hate
casts more than I hate assembly code and using the restart_block to save 
the arguments implys casts.

Jim Houston - Concurrent Computer Corp.
