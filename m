Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272634AbSISTpi>; Thu, 19 Sep 2002 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272635AbSISTpi>; Thu, 19 Sep 2002 15:45:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20866 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272634AbSISTph>; Thu, 19 Sep 2002 15:45:37 -0400
Date: Thu, 19 Sep 2002 15:53:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Richard Henderson <rth@twiddle.net>
cc: Brian Gerst <bgerst@didntduck.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919124117.A22720@twiddle.net>
Message-ID: <Pine.LNX.3.95.1020919154730.16046A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Richard Henderson wrote:

> On Thu, Sep 19, 2002 at 03:40:52PM -0400, Richard B. Johnson wrote:
> > Well it's not modifying those values.
> 
> It's not modifying "a", true, but it _is_ modifying the parameter
> area.  Which is exactly the kernel bug in question.
> 

Yep. This can't be found by the compiler. The parameter area is
writable so it looks like somebody needs to do some 'code inspection'
and some additional testing.

> > It's really bad code because it could have done:
> > 
> > 	incl	$0x04(%esp)
> > 	incl	$0x08(%esp)
> > 	incl	$0x1c(%esp)
> > 	jmp	bar
> 
> Yes, I know.
> 

It's a problem with a 'general purpose' compiler that wants to
be "all things" to all people. If somebody made a gcc-compatible
compiler, tuned to the ix86 characteristics, I think we could
cut the extra instructions by at least 1/2, maybe more.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

