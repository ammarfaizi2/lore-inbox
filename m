Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290616AbSA3VY2>; Wed, 30 Jan 2002 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290628AbSA3VYP>; Wed, 30 Jan 2002 16:24:15 -0500
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:62944 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290625AbSA3VXp>; Wed, 30 Jan 2002 16:23:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
Date: Wed, 30 Jan 2002 16:24:55 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.3.95.1020130110350.15189A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020130110350.15189A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130212344.ZLSQ25963.femail43.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 11:07 am, Richard B. Johnson wrote:
> When I ping two linux machines on a private link, I get 0.1 ms delay.
> When I send large TCP/IP stream data between them, I get almost
> 10 megabytes per second on a 100-base link. Wonderful.
>
> However, if I send 64 bytes from one machine and send it back, simple
> TCP/IP strean connection, it takes 1 millisecond to get it back? There
> seems to be some artifical delay somewhere.  How do I turn this OFF?

This is just a guess, but it sounds to me like a scheduling issue.  When 
you're sending data from one network stack to another, how often the 
receiving program scoops data out of the incoming file descriptor isn't too 
much of a limiting factor, as long as you've got enough buffer space in the 
receiving network stack that the sender doesn't have to pause.

But to bounce the data back, the program at the far end doing the receive and 
resend has be woken up and handed a time slice with which to receive, 
process, and return the packet.

Have you tried ingo's O(1) scheduler? :)

> Cheers,
> Dick Johnson

Rob
