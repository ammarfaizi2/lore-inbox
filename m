Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279824AbRKRPOG>; Sun, 18 Nov 2001 10:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRKRPN5>; Sun, 18 Nov 2001 10:13:57 -0500
Received: from elin.scali.no ([62.70.89.10]:23304 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S279798AbRKRPNk>;
	Sun, 18 Nov 2001 10:13:40 -0500
Date: Sun, 18 Nov 2001 16:13:35 +0100 (CET)
From: Terje Eggestad <terje.eggestad@scali.no>
To: Rock Gordon <rockgordon@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Executing binaries on new filesystem
In-Reply-To: <20011117221821.66121.qmail@web14809.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0111181602220.1899-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Rock Gordon wrote:

> Hi,
>
> I've written a modest filesystem for fun, it works
> pretty ok, but when I try to execute binaries from it,
> bash says "cannot execute binary file" ... If I copy
> the same binary elsewhere, it executes perfectly.
>
> Does anybody have any clue ?

Yes

keep in mind taht the kernel do demand paging of the text (code) in our
executable, meaning that a page of code is not loaded into the procs
memory spce (and thus phys mem) until the proc actually tries to exec the
code page. This is one manifestation of the funny term "page fault"!

I do belive that the current kernel uses mmap to map in the exec file text
segment. (Even if I can hear the ice cracking under my feet, never
actually looked at the code handling execs) but if you strace anexec that
uses shared libs you'll note that the sh.libs are mmaped into the process
space. (also note the MMAP_EXEC flag in the mmap(2) man page).


TJ

>
> Regards,
> Rock
>
> __________________________________________________
> Do You Yahoo!?
> Find the one for you at Yahoo! Personals
> http://personals.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

