Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVL0EqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVL0EqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVL0EqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:46:16 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:44252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932220AbVL0EqP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:46:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NwfetVXc+qkALB2qiaLkTXaEPdvVBWTPtD4KgtLknEZ9wRjleDxxGMUouPUKnPts/PaNyztLjNSUOQWA5BcFDsLaWH13HXcLhIuYxMmOA7w9/dUlne4arfAbH9mT23OzYecMEHwO3zhJnCZGM3y/t6xkmTAI0AO+AbwsSQD/5Wc=
Message-ID: <7cd5d4b40512262046w6f7a8161jfaf1e618e5722b4@mail.gmail.com>
Date: Tue, 27 Dec 2005 12:46:14 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org, robert love <rml@novell.com>
Subject: something about jiffies wraparound overflow
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

we use the following to solve the problem of jiffies wraparound.
#define time_after(a,b)		\
	(typecheck(unsigned long, a) && \
	 typecheck(unsigned long, b) && \
	 ((long)(b) - (long)(a) < 0))
#define time_before(a,b)	time_after(b,a)

#define time_after_eq(a,b)	\
	(typecheck(unsigned long, a) && \
	 typecheck(unsigned long, b) && \
	 ((long)(a) - (long)(b) >= 0))
#define time_before_eq(a,b)	time_after_eq(b,a)

But I cannot understand it has some differences comparing with the
following code.

/* code 2*/

unsigned long timeout = jiffies + HZ/2;

if(timeout < jiffies)
{
        /* not timeout...*/
}
else
{
        /* timeout processing...*/
}

questions:
  1.why the macros of time_after can solve the jiffies wraparound problem?
  2.Is there any other possibilities for the "code 2" to overflow
except the jiffies overflow?

Any help will be preferred .
Thank you,


Yours.
