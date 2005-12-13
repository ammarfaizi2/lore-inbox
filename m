Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVLMSrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVLMSrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVLMSrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:47:06 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64012 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030205AbVLMSrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:47:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <e46c534c0512131030v45640694t1030468ac5775804@mail.gmail.com>
X-OriginalArrivalTime: 13 Dec 2005 18:47:00.0204 (UTC) FILETIME=[99D84AC0:01C60015]
Content-class: urn:content-classes:message
Subject: Re: Possible problem in fcntl
Date: Tue, 13 Dec 2005 13:46:59 -0500
Message-ID: <Pine.LNX.4.61.0512131337240.8529@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Possible problem in fcntl
Thread-Index: AcYAFZnhVq2HzF00QMOu1lGG1bAHZA==
References: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com> <Pine.LNX.4.61.0512131242280.8370@chaos.analogic.com> <e46c534c0512131030v45640694t1030468ac5775804@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Filipe Cabecinhas" <filcab@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Nuno Lopes" <ncpl@mega.ist.utl.pt>,
       "Renato Crissstomo" <racc@mega.ist.utl.pt>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2005, Filipe Cabecinhas wrote:

> On 12/13/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
>> So what is it that the socket doesn't do, that you expect it
>> should do?
>>
>
> When we call recv on that socket, it returns 0 and sets the string to
> "" (as if the the client had done an orderly shutdown (which is not
> true, since wget says connection refused).
>

How do you know what wget did after the connection was refused?
Didn't it close its socket when returning to the shell?

> We were expecting it to return -1 and set errno to EAGAIN (or to
> return the number of bytes written and set the string to what it
> received).
>

But you said the connection was refused. Wget wouldn't have sent
anything.

> It works as expected if we don't have that (second) fcntl call. But,
> as the accept manpage tells us, in linux the socket returned by accept
> () does  not  inherit  file status  flags such as O_NONBLOCK, so we
> think we should call it (to be sure it has that flag). And, even if it
> isn't necessary, we can't tell why it's breaking (because it would
> just be setting a flag (that is already set )).
>

You can always display the results of fcntl(s, F_GETFL) after
changing it to see if it "works".

Did you use setsockopt() to set the socket to SO_BSDCOMPAT if you
are porting or copying BSD code?

> Thanks in advance,
> Filipe Cabecinhas
>

Also, since probably 90% of the Web-Pages accessed on the Internet
are served by Linux servers, it is highly unlikely that Linux is
doing something wrong in its socket code. FYI, there is a seperate
networking list........

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
