Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSGGVif>; Sun, 7 Jul 2002 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSGGVie>; Sun, 7 Jul 2002 17:38:34 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:52435 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316599AbSGGVid> convert rfc822-to-8bit; Sun, 7 Jul 2002 17:38:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [OKS] Module removal
Date: Sun, 7 Jul 2002 23:41:22 +0200
User-Agent: KMail/1.4.1
Cc: Bill Davidsen <davidsen@tmr.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
References: <20020702133658.I2295@almesberger.net> <20020704035012.O2295@almesberger.net> <20020707220933.B11999@kushida.apsleyroad.org>
In-Reply-To: <20020707220933.B11999@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207072341.22896.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> To do this, have the `free_module' function use `smp_call_function' to
> ask every CPU "are you executing code for module XXX?".  The question is
> answered by a routine which walks the stack, checking the instruction
> pointer at each place on the stack to see whether it's inside the module
> of interest.
>
> Yes this is complex, but it's not that complex -- provided you can rely
> on stack walking to find the module.  (It wouldn't work if x86 used
> -fomit-frame-pointer, for example).

How do you find CPU's that are about to execute module code ?

IMHO you need to do this freeze trick before you check the module
usage count.

[..]
> Another possibility would be the RCU thing: execute the module's exit
> function, but keep the module's memory allocated until some safe
> scheduling point later, when you are sure that no CPU can possibly be
> running the module.

But what do you do if that CPU increases the module usage count?

	Regards
		Oliver

