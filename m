Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269802AbUJGNAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269802AbUJGNAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269815AbUJGM43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:56:29 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:41373 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269714AbUJGMxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:53:34 -0400
Date: Thu, 7 Oct 2004 13:53:14 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Martijn Sipkema <martijn@entmoot.nl>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <001601c4ac72$19932760$161b14ac@boromir>
Message-ID: <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com>
 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Martijn Sipkema wrote:

> That there is time between the select() and recvmsg() calls is not 
> the issue; the data is only checked in the call to recvmsg(). 
> Actually the longer the time between select() and recvmsg(), the 
> larger the probability that valid data has been received.

But it is the issue.

Much can change between the select() and recvmsg - things outside of 
kernel control too, and it's long been known.

> But the standard clearly says otherwise.

Standards can have bugs too.

It's not healthy to take a corner-case situation from the standard on 
select() and apply it globally to all IO. (not in my mind anyway, 
whatever the standard says).

> Perhaps select()'s perception of state should be made to take possible
> corruption into account.

You'll /still/ run into problems, on other platforms too. Set socket 
to O_NONBLOCK and deal with it ;)

> Why would the POSIX standard say recvmsg() should not block if
> it did not intend it to be used in that way?

POSIX_ME_HARDER? ;)

> Wrong. IMHO it is not exactly a good thing to not be compliant on 
> such basic functionality.

Like I said, to my mind, any sane app should try avoiding assumption 
that kernel state remains same between select() and read/write - and 
O_NONBLOCK exists to deal nicely with the situation.

You really shouldnt assume select state is guaranteed not to change 
by time you get round to doing IO. It's not safe, and not just on 
Linux - whatever POSIX says.

> --ms

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"An ounce of prevention is worth a pound of purge."
