Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274105AbRISQ7Q>; Wed, 19 Sep 2001 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274110AbRISQ7G>; Wed, 19 Sep 2001 12:59:06 -0400
Received: from cmail.ru ([195.2.82.126]:33033 "EHLO cmail.ru")
	by vger.kernel.org with ESMTP id <S274105AbRISQ6s>;
	Wed, 19 Sep 2001 12:58:48 -0400
Date: Wed, 19 Sep 2001 20:57:25 +0400
Message-Id: <200109191657.f8JGvPJ06663@cmail.ru>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Andrew V. Samoilov" <kai@cmail.ru>, linux-kernel@vger.kernel.org
From: "Andrew V. Samoilov" <kai@cmail.ru>
Reply-to: "Andrew V. Samoilov" <kai@cmail.ru>
X-Mailer: Perl Mail::Sender 0.7.04 Jan Krynicky  http://jenda.krynicky.cz/
MIME-Version: 1.0
Content-type: text/plain; charset="koi8-r"
Subject: Re: mmap successed but SIGBUS generated on access
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jamie!

Thanks for an answer!

>> I have bad CD-R with a some number of unreadable
files.
>> 
>> Then user-space program use mmap system it returns ok
but any
>> attempt to access a memory pointed by this system
call finishes 
>> with SIGBUS. So Midnight Commander internal file
viewer faults.
>
>You can get the same problem even without read errors
with some
>configurations of NFS.  (root mmaps a file owned by
someone else, but
>cannot read the file due to `root_squash' on server).
>
>It's not an error, it's standard behaviour.

Well.

>> Is there any way to detect such problem in user-space
without signal
>> handlers ?
>
>I don't think there is any way without a signal
handler.
>
>It is possible to do something useful with a signal
handler sometimes.
>For example, you can mmap() a zero page into the
offending page once
>you've got the fault address, or read() a zero page if
you did
>MAP_PRIVATE (this produces fewer VMAs), set a flag, and
let the program
>continue until it checks the flag and aborts the
parsing or whatever
>operation it's doing.

So, I must read all of the mapped area and even this
does not saves me of faulting next time if somebody
change file permission. Does I understand this situation
right?

>Unfortunately I don't think the signal handler's
si_errno is set
>properly to indicate the error.  So another thing to
try is read() of
>the offending page, to get a useful error code.  (And
if the read
>succeeds, that's ok because you did it at the correct
address so the
>program can proceed anyway).
>
>Fwiw, unfortunately not all versions of the kernel, or
all
>architectures, set si_addr properly for SIGBUS.

It's pity. But thanks again.

--
Regards,
Andrew.

____________________________________________

Играй в шахматы в Интернет на InstantChess.com! 

Play chess on InstantChess.com !

www.instantchess.com


