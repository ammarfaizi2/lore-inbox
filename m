Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263222AbTCNBCK>; Thu, 13 Mar 2003 20:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbTCNBAu>; Thu, 13 Mar 2003 20:00:50 -0500
Received: from [12.36.124.2] ([12.36.124.2]:16331 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S263207AbTCNA5s>; Thu, 13 Mar 2003 19:57:48 -0500
Mime-Version: 1.0
Message-Id: <p05210514ba96db3fb9e9@[10.2.0.101]>
In-Reply-To: <Pine.LNX.4.44.0303131522390.23207-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303131522390.23207-100000@home.transmeta.com>
Date: Thu, 13 Mar 2003 17:08:26 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:24pm -0800 3/13/03, Linus Torvalds wrote:
>On Thu, 13 Mar 2003, Horst von Brand wrote:
>>
>>  No need. Just dump some bytes before EIP raw, plus raw bytes + decoded
>>  after EIP. Could be of some help.
>
>Alpha does this. Of course, there you don't have any of the partial
>instruction issues.

If you've got a symbol some reasonable distance before EIP, you could 
decode from there. I wrote a little code that does that (using 
kallsyms) very crudely in the stack trace in order to give the reader 
a hint about stack frames. Go to the prior symbol, which is usually 
an entry point, and find the %esp arithmetic. Works pretty well for 
figuring out the real call chain.
-- 
/Jonathan Lundell.
