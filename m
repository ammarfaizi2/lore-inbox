Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSH1A24>; Tue, 27 Aug 2002 20:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSH1A24>; Tue, 27 Aug 2002 20:28:56 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:32773
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318062AbSH1A2z>;
	Tue, 27 Aug 2002 20:28:55 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 27 Aug 2002 17:32:58 -0700
MIME-Version: 1.0
Subject: Re: Bug in kernel code?
CC: linux-kernel@vger.kernel.org
Message-ID: <3D6BB7CA.26619.363BFC@localhost>
In-reply-to: <20020827.172304.22017977.davem@redhat.com>
References: <3D6BB5C3.16057.2E515C@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2002 at 17:23, David S. Miller wrote:

>    From: "Stephen C. Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 17:24:19 -0700
> 
>    ........... Notice the --order >=0 in the do while test... since order is declared as an unsigned 
>    long, this test is a pointless comparison and never fails, causing an infinite loop if the 
>    hashtable is empty.  
>    
>    My fix to this is to change the test to have
>    while (dentry_hashtable == NULL && order-- != 0);
>    
>    Could someone check me on this?
>    
> Your analysis is right but the fix is wrong, we do want to
> try order == 0 on very small memory systems, and you should
> not decrement the order at the beginning of the loop.  We
> want to use the "order" calculated.
> 
> Just make 'order' signed long to fix this bug.
> 

NO!  That won't work either.  This is a "do while" loop so the first test is always done and if 
order is 0, the check will be done AFTER the decrement, so this works.  Changing it to a signed 
long loses you a bit.
