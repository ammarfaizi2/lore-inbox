Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSBDAui>; Sun, 3 Feb 2002 19:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSBDAu2>; Sun, 3 Feb 2002 19:50:28 -0500
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:13776 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288021AbSBDAuQ>; Sun, 3 Feb 2002 19:50:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
Subject: Re: packet created by local raw socket
Date: Sun, 3 Feb 2002 19:51:20 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.10.10202031800220.24685-100000@dogbert>
In-Reply-To: <Pine.SOL.4.10.10202031800220.24685-100000@dogbert>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204005015.DXSW15583.femail44.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 February 2002 07:24 pm, Xinwen - Fu wrote:
> Rob,
> 	Thanks for your reply! It's very good!
>
>
> 	In fact my problem is simpler to you( the
> last email is not clear):
>
> 	Now I create a raw socket(SOCK_RAW) on a local machine, construct
> a ICMP packet and send it out. So what queues will this packet go through?

Locally generated packets seem to go through the tests in the output table 
first, then on to postrouting.  I didn't think the type of the locally 
generated packet mattered.  (I know UDP, TCP, or ICMP don't...)

> 	I tested it and it seems that this packet first goes to OUTPUT
> queue. is that right?

Sounds about right.

> If so, then ip stack's interface to RAW socket
> should be below the function of appending IP header to a transport layer
> datagram but above the routing decision function and also above the
> OUTPUT queue, am I right?

If you asked for a raw socket, the system won't append an IP header to it for 
you.  You asked it not to.

It has to come before the routing decision.  Otherwise how does it know where 
to send it?  (You might have more than one network interface in the machine.  
Two ethernet cards, or ethernet and ppp...)

> Thanks!
>
> Fu

Have you tried the "logging" target?  It's loads of fun for this sort of 
thing...

Rob
