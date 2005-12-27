Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVL0KE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVL0KE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVL0KE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:04:59 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:55444 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932287AbVL0KE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:04:58 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: something about jiffies wraparound overflow
To: jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org,
       robert love <rml@novell.com>
Reply-To: 7eggert@gmx.de
Date: Tue, 27 Dec 2005 11:06:05 +0100
References: <5oeWK-5Od-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ErBiY-0000c6-Ic@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia <tshxiayu@gmail.com> wrote:

> we use the following to solve the problem of jiffies wraparound.
> #define time_after(a,b)               \
> (typecheck(unsigned long, a) && \
> typecheck(unsigned long, b) && \
> ((long)(b) - (long)(a) < 0))
> #define time_before(a,b)      time_after(b,a)

[...]

> But I cannot understand it has some differences comparing with the
> following code.
> 
> /* code 2*/
> 
> unsigned long timeout = jiffies + HZ/2;
> 
> if(timeout < jiffies)

> questions:
>   1.why the macros of time_after can solve the jiffies wraparound problem?

Because the overflows get compensated. It's a property of Galois Fields.

>   2.Is there any other possibilities for the "code 2" to overflow
> except the jiffies overflow?

timeout might overflow, too.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
