Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUILJKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUILJKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUILJKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:10:52 -0400
Received: from outbound04.telus.net ([199.185.220.223]:55776 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S268538AbUILJK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:10:26 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial of Service
Date: Sun, 12 Sep 2004 03:10:29 -0600
Message-ID: <000f01c498a8$59b24700$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <025e01c4989c$ba5f62b0$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
> 
> If the application doesn't close it's file descriptors there 
> is absolutely nothing the kernel can do about it.
> 
> It's a resource leak, plain and simple.
> 
> > That being said - below is a the proper description, and 
> the code used
> > to exploit it. Hope it helps. This version is not the one which 
> > invokes the CLOSE_WAIT state, but rather the TIME_WAIT one, 
> I am not 
> > able to publish the source code for the CLOSE_WAIT bug.
> 
> There is nothing wrong with creating tons of TIME_WAIT 
> sockets, they simply time out after 60 seconds (unless hit by 
> a RESET packet or similar).  This is how TCP works.

I am aware of that, you are missing the point. The point is
the part where the socket is reused before it is completely
closed, the end result being the daemon its pointed at keeps
the connection open, and thus ends up in a DOS condition.

Please do me a favor, and read the bug before you comment.

> 
> > The log however clearly shows that a mysql descriptor is 
> closed, and 
> > then used immediately again by the socket call, which 
> causes it never 
> > to end up getting closed. Linux apparently has either no 
> timeout for 
> > CLOSE_WAIT, or it's a very very long one.. Either way is a 
> bad thing.
> 
> Please do us all a favor and learn how TCP works.

A) Stop asking me for favors.
B) You have some serious aggression issues you need to work on :) I
   openly admitted not submitting issues before at the beginning of
   my first email, did I miss the part where it became required for
   you to turn into an asshole? :) I can see why people would toss
   exploits off to the zeroday groups, you get a more warm reception 
   when you report a bug, and it ends up fixed in the end, instead of
   overrun with excuses :)

> CLOSE_WAIT means simply that only one side of the TCP 
> connection has done a close.  Therefore the other end stays 
> open until that side closes as well.
> 
> There is no way to "time things out" or release the
> state.
> 

This is your "godly developer answer" to this bug? Ok, well,
so I am to assume that this is the mission of the kernel:

A) All software must run perfectly, because we "can't do anything
   about resource leaks"
B) The internet is perfect, and there are no problems with TCP, so
   we can't add a timeout for CLOSE_WAIT, we must just leave it there
   forever. Forget the fact it could potentially bring the server, or
   the daemon it is speaking to down to its knees.
C) Don't submit bugs, because David likes to tell you that you know
   nothing, and "as a favor" to please go and find out what the hell
   your talking about. He obviously knows everything, so please, stop
   insulting his mailing list.

Is that correct? Here and I thought the job of the operating system was
to deal with issues such as this. If this is indeed where Linux is headed,
I fear the internet may be in a good deal of trouble.

For the record, I believe Microsoft Windows, and FreeBSD both have timeouts
for this TCP State. But, I better go learn how they work, before I make
such a comment.

Regards,
Dale.

