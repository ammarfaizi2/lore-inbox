Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSLIRwz>; Mon, 9 Dec 2002 12:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSLIRwz>; Mon, 9 Dec 2002 12:52:55 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:49799 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265982AbSLIRws> convert rfc822-to-8bit; Mon, 9 Dec 2002 12:52:48 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFD8A28E03.33C21720-ONC1256C8A.00616515@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 9 Dec 2002 18:56:30 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2002 18:59:01
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, that is tricky independently of the actual argument stuff - even
the
> _current_ system call restart ends up being tricky for you in that case,
I
> suspect. The current one already basically depends on rewriting the
system
> call number, it just leaves the arguments untouched.

The current system call restart doesn't change the system call number. We just
substract two from the psw address (aka eip) and go back to user space.

> One thing you could do (which is pretty much architecture-independent) is
> to have a "restart" flag in the thread info structure. The system call
> entry code-path already has to check the thread info structure for things
> like the "ptrace" flags, so it shouldn't add much overhead to the system
> call entrypoint.

Hmm, probably the best thing to do. I though about changing the return address
in the last frame of the stack but this is ugly and confuses the code. Another
flag in thread_info (_TIF_RESTART?) doesn't add any instruction on the hot
path in the system call handler and is simple enough to implement.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


