Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269655AbUJGNN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbUJGNN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUJGNKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:10:52 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:35250 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267323AbUJGNHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:07:35 -0400
Message-ID: <001c01c4ac76$fb9fd190$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Paul Jakma" <paul@clubi.ie>
Cc: "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, <joris@eljakim.nl>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 15:07:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul Jakma" <paul@clubi.ie>
Sent: Thursday, October 07, 2004 13:53


> On Thu, 7 Oct 2004, Martijn Sipkema wrote:
> 
> > That there is time between the select() and recvmsg() calls is not 
> > the issue; the data is only checked in the call to recvmsg(). 
> > Actually the longer the time between select() and recvmsg(), the 
> > larger the probability that valid data has been received.
> 
> But it is the issue.
> 
> Much can change between the select() and recvmsg - things outside of 
> kernel control too, and it's long been known.

There is no change; the current implementation just checks the validity of
the data in the recvmsg() call and not during select().

> > But the standard clearly says otherwise.
> 
> Standards can have bugs too.
> 
> It's not healthy to take a corner-case situation from the standard on 
> select() and apply it globally to all IO. (not in my mind anyway, 
> whatever the standard says).


Read the standard. The behavious of select() on sockets is explicitely
described.

> > Perhaps select()'s perception of state should be made to take possible
> > corruption into account.
> 
> You'll /still/ run into problems, on other platforms too. Set socket 
> to O_NONBLOCK and deal with it ;)

What problems?

> > Why would the POSIX standard say recvmsg() should not block if
> > it did not intend it to be used in that way?
> 
> POSIX_ME_HARDER? ;)

Would you care to provide any real answers or are you just telling
me to shut up because whatever Linux does is good, and not appear
unreasonable by adding a ;) ..?

> > Wrong. IMHO it is not exactly a good thing to not be compliant on 
> > such basic functionality.
> 
> Like I said, to my mind, any sane app should try avoiding assumption 
> that kernel state remains same between select() and read/write - and 
> O_NONBLOCK exists to deal nicely with the situation.
> 
> You really shouldnt assume select state is guaranteed not to change 
> by time you get round to doing IO. It's not safe, and not just on 
> Linux - whatever POSIX says.

Any sane application would be written for the POSIX API as described
in the standard, and a sane kernel should IMHO implement that standard
whenever possible.

--ms

