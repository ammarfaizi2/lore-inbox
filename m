Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTKOJOY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKOJOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:14:24 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:1514 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261670AbTKOJOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:14:22 -0500
Message-ID: <3FB5EE6A.8080801@cyberone.com.au>
Date: Sat, 15 Nov 2003 20:14:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: David Nielsen <Lovechild@foolclan.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v19
References: <1065350173.4946.5.camel@pilot.stavtrup-st.dk>	 <3F80DF3C.8010406@cyberone.com.au> <3F81123F.4040609@cyberone.com.au>	 <3F811E02.3060803@cyberone.com.au>  <3F8140CF.9050603@cyberone.com.au>	 <1065612151.4782.4.camel@pilot.stavtrup-st.dk>	 <3F9907EB.7050700@cyberone.com.au> <1067175079.664.7.camel@pilot.stavtrup-st.dk>
In-Reply-To: <1067175079.664.7.camel@pilot.stavtrup-st.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/v19/

Quite a few changes. Although inter node and intra node migration is
generally reduced in my patches, it seems probably context switching
is hurting more. This would explain the decreased system time and
increased user time - the user code is thrashing the cache more.

I haven't addressed that problem yet, although I have removed the
last (I think) major source of cacheline dirtying between CPUs. I say
major, but it was difficult to measure a difference on a 16-way NUMAQ.

For desktop users, microsecond accounting. This currently incurs a
bit of unneeded overhead because I have to convert from 64-bit nanoseconds
to 32-bit microseconds everywhere. I'm using microseconds because a 32-bit
value can store a maximum interval of about 4 seconds in nanoseconds, which
causes me all sorts of overflow problems.

I'm pleased to have had good results with HZ timing up until now. I think
this helps interactivity but I haven't had many problems with it myself.
Its against mm3 but I can do a patch against Linus' tree.

Best regards,
Nick


