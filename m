Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317509AbSFIB5y>; Sat, 8 Jun 2002 21:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317507AbSFIB5x>; Sat, 8 Jun 2002 21:57:53 -0400
Received: from mail.webmaster.com ([216.152.64.131]:60336 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317502AbSFIB5w> convert rfc822-to-8bit; Sat, 8 Jun 2002 21:57:52 -0400
From: David Schwartz <davids@webmaster.com>
To: <cohen@rafb.net>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Sat, 8 Jun 2002 18:57:49 -0700
In-Reply-To: <12812896964.20020607130905@rafb.net>
Subject: Re: kernel 2.4.18 - select() returning strange value
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020609015751.AAA13941@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Jun 2002 13:09:05 -0700, Jacob Cohen wrote:

>Summary: when calling select() on a set of file descriptors containing
>only the descriptor of a non-connected stream socket, select() returns
>1 and marks the FD set as if data were waiting on the socket.

	This seems correct to me. A read or write will not block and there is 
nothing to wait for.

>According to what I've read in the man pages for select() and
>socket(), a nonconnected socket should be unreadable, and therefore
>select() should timeout and return 0. I cannot figure out why it is
>returning 1.

	Because the socket is ready for read. If a read were attempted immediately, 
it would not block. If a read would result in an error other than 
'EWOULDBLOCK', the socket is ready to be read.

>Has something changed in the kernel or the way the select() syscall
>behaves on a nonconnected socket that I should be aware of? I cannot
>find anything relevant in the recent change logs, but I am probably
>missing something.

	I'm guessing the previous erroneous behavior was fixed. When you 'select' on 
an unconnected socket, what do you expect 'select' to wait for?

	DS


