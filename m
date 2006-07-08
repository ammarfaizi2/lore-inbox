Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWGHIgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWGHIgl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGHIgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:36:41 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:29459 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750751AbWGHIgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:36:40 -0400
Message-ID: <44AF6E92.3000000@argo.co.il>
Date: Sat, 08 Jul 2006 11:36:34 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2006 08:36:38.0698 (UTC) FILETIME=[A13C30A0:01C6A269]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>
> >> The 'C' compiler has no choice but to actually make that memory access
> >> and read the variable because the variable is in another module 
> (a.k.a.
> >> file).
>

[code showing the compiler may cache the access]

> So read the code; you have "10:   jne 10", jumping to itself
> forever, without even doing anything else to set the flags, much
> less reading a variable.
>

Short attention span, eh? He's proven you wrong and you go on and talk 
about something else.

> >
> >> However, if I have the same code, but the variable is visible during
> >> compile time, i.e.,
> >>
> >> int spinner=0;
> >>
> >> funct(){
> >>      while(spinner)
> >>          ;
> >>
> >> ... the compiler may eliminate that code altogether because it
> >> 'knows' that spinner is FALSE, having initialized it to zero
> >> itself.
> >
>

[code showing that defining the variable in the same translation unit 
makes no difference]

> Then, you have exactly the same thing here:
>    10:   75 fe                   jne    10 <funct+0x10>
>
> Same bad code.
>

You seem to have forgotten that you claimed different code would be 
generated.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

