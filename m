Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278322AbRJMQFh>; Sat, 13 Oct 2001 12:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278321AbRJMQF2>; Sat, 13 Oct 2001 12:05:28 -0400
Received: from [212.21.93.146] ([212.21.93.146]:48771 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278333AbRJMQFO>; Sat, 13 Oct 2001 12:05:14 -0400
Date: Sat, 13 Oct 2001 18:05:09 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jan Hudec <bulb@ucw.cz>, "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
Message-ID: <20011013180509.E20499@kushida.jlokier.co.uk>
In-Reply-To: <3BC1D506.E68B9DB2@isg.de> <20011009153702.B28423@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011009153702.B28423@artax.karlin.mff.cuni.cz>; from bulb@ucw.cz on Tue, Oct 09, 2001 at 03:37:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:
> Well, but you don't have to call sigsetjmp before every select; just when you
> enter the loop. Than just enable volatile flag, that the handler should now
> use the siglongjmp... well, you have to care about 2 signals quickly following
> one another and similar nasty cases anyway, so the pipe aproach is less
> error-prone.

You don't have to worry about 2 signals following each other if they are
the same signal: you can clear the volatile flag in the signal handler.

If they are different signals, e.g. SIGCHLD arrives during SIGINT
handler inside select(), then it's more complicated.

The pipe is very simple to get right and at least as fast as a signal
handler.  Just make sure you can't ever make the mistake of writing to a
full pipe.  Netscape 4.x does this and that's why it freezes from time
to time.  It's an easy problem to avoid.

-- Jamie
