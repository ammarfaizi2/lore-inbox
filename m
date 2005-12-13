Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVLMRuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVLMRuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLMRuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:50:18 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:21005 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751277AbVLMRuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:50:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com>
X-OriginalArrivalTime: 13 Dec 2005 17:50:09.0738 (UTC) FILETIME=[A90C7AA0:01C6000D]
Content-class: urn:content-classes:message
Subject: Re: Possible problem in fcntl
Date: Tue, 13 Dec 2005 12:50:04 -0500
Message-ID: <Pine.LNX.4.61.0512131242280.8370@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Possible problem in fcntl
Thread-Index: AcYADakTVfM/XmRKRw2HDw4uubh4vw==
References: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Filipe Cabecinhas" <filcab@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Nuno Lopes" <ncpl@mega.ist.utl.pt>,
       =?iso-8859-1?Q?Renato_Cris=F3stomo?= <racc@mega.ist.utl.pt>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2005, Filipe Cabecinhas wrote:

> Hi,
>
> We have written a little webserver for our CS course. But we have a
> problem with fcntl.
> We are using non-blocking sockets and per fcntl man page:
>       On Linux, the new socket returned by accept () does  not  inherit  file
>       status  flags such as O_NONBLOCK and O_ASYNC from the listening socket.
>       This behaviour differs from the canonical BSD  sockets  implementation.
>       Portable  programs should not rely on inheritance or non-inheritance of
>       file status flags and always explicitly set all required flags  on  the
>       socket returned from accept().
>

Okay already. What is it that it doesn't do that you expect it to do?

> We call fcntl after calling bind and listen. Then we also call fcntl
> for each accept'ed connection to set O_NONBLOCK:
> 				flags = fcntl(e, F_GETFL);
> 				fcntl(e, F_SETFL, flags | O_NONBLOCK);
>
> $ uname -a
> Linux lab9p2 2.6.11.12 #3 Sat Sep 3 20:09:17 WEST 2005 i686 Intel(R)
> Pentium(R) 4 CPU 2.26GHz GenuineIntel GNU/Linux
> $
>
> The code is at http://mega.ist.utl.pt/~facab/proj/
> (files httpd.n.[ch] have the line numbers)
> The line that's causing the trouble is line 377 in httpd.c. Commenting
> that line fixes the problem (although we think that shouldn't be
> necessary).
>

So what is it that the socket doesn't do, that you expect it
should do?

> However, in my laptop (with a different kernel version) it works. So,
> does this kernel version (2.6.11.12) has a bug with fcntl or are we
> doing something wrong?
>

What is it that you expect it to do? Networking exists at several
levels. You may have to use setsockopt() to set some socket parameters
for some kinds of sockets. The 'fact' that something worked in
some previous code does not mean that the code was correct.

> Thanks in advance,
> Filipe Cabecinhas
>
> P.S: Please CC me, because I'm not subscribed to this list.
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
