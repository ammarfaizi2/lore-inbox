Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272105AbRHVVk5>; Wed, 22 Aug 2001 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272129AbRHVVks>; Wed, 22 Aug 2001 17:40:48 -0400
Received: from mail.webmaster.com ([216.152.64.131]:16299 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S272113AbRHVVkh>; Wed, 22 Aug 2001 17:40:37 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Jagdis" <jaggy@purplet.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() says closed socket readable
Date: Wed, 22 Aug 2001 14:40:51 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMAECLDGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
In-Reply-To: <3B837AB3.40308@purplet.demon.co.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No. If there is a correct behaviour defined in a standard we should
> do that. Otherwise we should do what other systems do _unless_ there
> is a clear benefit to doing something else. In this case doing
> something else appears to create porting problems and confusion over
> what select(2) means without any clear benefit.

> 				Mike

	There is a clear and significant benefit. Bugs that result in a program
calling 'select' on an unconnected socket will be easily and quickly
detected. During debugging, they can then be fixed. During release
execution, they can be worked around.

	There are a large number of possible mistakes that can result in this
behavior. A program that heavily uses sockets could sometimes forget to
remove a socket from its active poll/select set. A program might
accidentally close the wrong socket (and that socket might get reused by a
subsequent call to 'socket'). It's nice to have a way to catch these. During
debug, socket errors are routinely logged or displayed, so this would get
caught.

	Of course, this isn't so much of a benefit that it's worth violating a
standard like POSIX. But it could be considered enough of a benefit that
it's worth not being compatable outside the bounds of such a standard.

	DS

