Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277473AbRJEQ2F>; Fri, 5 Oct 2001 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277474AbRJEQ1z>; Fri, 5 Oct 2001 12:27:55 -0400
Received: from foobar.isg.de ([62.96.243.63]:17900 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S277473AbRJEQ1w>;
	Fri, 5 Oct 2001 12:27:52 -0400
Message-ID: <3BBDDFAC.41AE9BD9@isg.de>
Date: Fri, 05 Oct 2001 18:28:28 +0200
From: lkv@isg.de
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <Pine.GSO.4.21.0110051214070.2267-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 5 Oct 2001 lkv@isg.de wrote:
> 
> > A somewhat bizarre solution would be to have the process create
> > a pipe-pair, select on the reading end, and let the signal-handler
> > write a byte to the pipe - but this has at least the drawback
> > you always spoil one "select-cycle" for each signal you get - as
> > the first return from the select() call happenes without any
> > fds being flagged as readable, only when you enter select() once
> > more the pipe will cause the return and tell you what happened...
> 
> fork() is cheap.  Create a child, have a pipe between child and
> parent and do select() on the other end of pipe.  I.e. signal handler
> writes into pipe and that triggers select() in the second process.

What exactly would be the advantage of doubling the number of processes
running just to introduce this indirection? An additional context-switch
surely doesn't speed up things... or am I misinterpreting your proposal
completely?

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
