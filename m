Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTCFNTR>; Thu, 6 Mar 2003 08:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTCFNTR>; Thu, 6 Mar 2003 08:19:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16009 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268060AbTCFNS6>; Thu, 6 Mar 2003 08:18:58 -0500
Date: Thu, 6 Mar 2003 08:31:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: prash_t@softhome.net
cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Inconsistency in changing the state of task ??
In-Reply-To: <courier.3E674902.000007D9@softhome.net>
Message-ID: <Pine.LNX.3.95.1030306081820.9822A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 prash_t@softhome.net wrote:

> Thanks Robert for the reply.
> But I notice that __set_current_state() is same as current->state. So, I 
> didn't understand the safety factor on using __set_current_state( ). 
> 
> Also why should I use __set_current_state() instead of set_current_state() 
> when the later is SMP safe. 
> 
> Thanks in advance....
> Prashanth 
[SNIPPED...]

Usually, it would not make any difference. However, there is a
de facto standard to not use "__functions" or "__macros" directly
in code. Those are the things that the integrator will change to
accommodate different configurations, i.e., whether you are running
on a '386, '686, PPC or Sparc, SMP/High-memory, etc. So, you use
function() instead of _function() or __function().  If you use this
standard you might start out with this in some header:

#define function(p)  __function(p)

But in SMP machines, you might need some other code. Rather than
you having to modify your source, some header changes the definition
and it might become:

#define function(p) do{ MB(); __function(p); } while (0)

How, if you had executed __function() directly in your code,
you end up tossing that driver into the scrap-heap until it
gets fixed for SMP.


Bottom line; Look at the headers. If you have a choice, don't
use a function or macro that has leading underscores. If you
copy "working" drivers, you can be copying latent bugs. Don't
blindly go where others have gone (Star-Trek fans blink).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


