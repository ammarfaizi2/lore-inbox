Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276978AbRJHQbr>; Mon, 8 Oct 2001 12:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJHQbi>; Mon, 8 Oct 2001 12:31:38 -0400
Received: from foobar.isg.de ([62.96.243.63]:41379 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S276978AbRJHQb2>;
	Mon, 8 Oct 2001 12:31:28 -0400
Message-ID: <3BC1D506.E68B9DB2@isg.de>
Date: Mon, 08 Oct 2001 18:32:06 +0200
From: lkv@isg.de
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The select system call doesn't return EINTR when the signal is caught
> > prior to entry into select.
> 
> Your friend there is siglongjmp/sigsetjmp - the same problem was true
> with old versions of alarm that did
> 
>         alarm(num)
>         pause()
> 
> on a heavily loaded box.
> 
> Using siglongjmp cures that

Hmmm... would you say the "siglongjmp" method is better than the "self-pipe"
method for a select on both file descriptors and signals too?

As far as I can see the trade-off is (in the non-race-condition case)
between having to call read() on the pipe (to empty it after receiving the
signal) for the "self-pipe" method and having to call sigsetjump() every time
before one enters select/poll.

My assumption would be that the "self-pipe" method is cheaper... right?

Then somebody mentioned using signals to wake up processes
for frequent events wouldn't be a good idea at all - why?
And what could be a better alternative given that there are N processes,
which all need to be able to wake up any of the other N-1 processes - where N
is big enough to prohibit dedicated channels between each possible process
pair, and given that it has to be a portable way that does not impose
the risk of leaking files to a disk?

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
