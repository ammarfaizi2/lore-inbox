Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUJGLxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUJGLxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUJGLxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:53:54 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:21658 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262085AbUJGLxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:53:51 -0400
Date: Thu, 7 Oct 2004 12:53:21 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <4164EBF1.3000802@nortelnetworks.com>
Message-ID: <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Chris Friesen wrote:

> Actually, in the single threaded case, the state did not change.  We just 
> didn't actually check the state before returning from select().

Right, so our perception of state (which for all useful purposes /is/ 
the state) changed - "we have data" -> "we had to throw out data due 
to bad checksum" is a change in kernel state at least, if not in the 
(now gone) data.

I'm not really a kernel person. From the application POV, in the 
single-threaded case (cause the multi-threaded case is fairly 
pathological anyway), there /will/ be time between the select and the 
recvmsg, things /can/ change, and obviously they do.

Treating select as anything other than a useful hints mechanism is 
going to get you into trouble - just see the Stevens' example others 
gave for a long-standing example, in addition to this (sane imho) 
Linuxism.

> Actually, there wasn't.  The data was corrupt, therefore there was 
> no data. Nothing changed with time, as the corrupt data was already 
> present before we returned from select().

Perception of state is as good as state here.

> POSIX says that if select() says a socket is readable, a read call 
> will not block.  Obviously, we are not POSIX compliant.

Right, yes, that seems to be clear now.

Though, I'd still say that any app that calls read/write functions 
without O_NONBLOCK set and that expects it will not block, is broken. 
Basic common sense really, never mind the fine details of POSIX on 
select(). ;)

> There's nothing wrong with not being compliant, but it should be 
> documented and we shouldn't claim to be compliant.

Right.

> Chris

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
A good reputation is more valuable than money.
 		-- Publilius Syrus
