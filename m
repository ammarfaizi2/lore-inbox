Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269740AbUJGHMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269740AbUJGHMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269744AbUJGHMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:12:17 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:55226 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269740AbUJGHLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:11:44 -0400
Message-ID: <4164EBF1.3000802@nortelnetworks.com>
Date: Thu, 07 Oct 2004 01:10:41 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> On Wed, 6 Oct 2004, Richard B. Johnson wrote:
>> thing --not. Select must return correct information.
> It does, it's just state that select() reported on changed by the time 
> user called recvmsg.

Actually, in the single threaded case, the state did not change.  We just didn't 
actually check the state before returning from select().

>> When a function call like select() says there are data available, 
>> there must be data available, period.

> There was, but there wasnt when recvmsg() was called. Time changes things.

Actually, there wasn't.  The data was corrupt, therefore there was no data. 
Nothing changed with time, as the corrupt data was already present before we 
returned from select().

> Any application that expects socket read not to block should set 
> O_NONBLOCK.

POSIX says that if select() says a socket is readable, a read call will not 
block.  Obviously, we are not POSIX compliant.

There's nothing wrong with not being compliant, but it should be documented and 
we shouldn't claim to be compliant.

Chris
