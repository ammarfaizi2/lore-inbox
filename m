Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277423AbRJEPg1>; Fri, 5 Oct 2001 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJEPgK>; Fri, 5 Oct 2001 11:36:10 -0400
Received: from foobar.isg.de ([62.96.243.63]:212 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S277417AbRJEPf5>;
	Fri, 5 Oct 2001 11:35:57 -0400
Message-ID: <3BBDD37D.56D7B359@isg.de>
Date: Fri, 05 Oct 2001 17:36:29 +0200
From: lkv@isg.de
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Desperately missing a working "pselect()" or similar...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently looking for a decent method to wait on either
an I/O event _or_ a signal coming from another process.

Alas, it seems that the Linux kernel does not have any
appropriate system call to support what for example "pselect()"
tries to do: Atomically enable some signals and entering a
select.

Without a proper pselect() implementation (the one in glibc is just
a mock-up that doesn't prevent the race condition) I'm currently
unable to come up with a good idea on how to wait on both types
of events.

A somewhat bizarre solution would be to have the process create
a pipe-pair, select on the reading end, and let the signal-handler
write a byte to the pipe - but this has at least the drawback
you always spoil one "select-cycle" for each signal you get - as
the first return from the select() call happenes without any
fds being flagged as readable, only when you enter select() once
more the pipe will cause the return and tell you what happened...


Arguments against other options I considered:

- Using just signals is at least prevented by SIGIO not being
  delivered for pipes, and I'm not eager to find out about
  all the other problems that may arise by devices not behaving
  as expected

- Unix domain sockets would be awkward to use due to the fact
  I'd need to come up with some "filenames" for them to bind to,
  and both security considerations and the danger of "leaking"
  files that remain on disk forever make me shudder...


Any ideas?
Anyone capable of implementing a system-call for pselect() (or ppoll) ?

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
