Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRCXBRh>; Fri, 23 Mar 2001 20:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRCXBR1>; Fri, 23 Mar 2001 20:17:27 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:62006 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S131533AbRCXBRQ>; Fri, 23 Mar 2001 20:17:16 -0500
Message-Id: <4.3.2.7.2.20010323170728.00b31100@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 23 Mar 2001 17:16:26 -0800
To: Linux Kernel <linux-kernel@vger.kernel.org>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] gcc-3.0 warnings
In-Reply-To: <20010323163129.B2534@kochanski.internal.splhi.com>
In-Reply-To: <20010323235909.C3098@werewolf.able.es>
 <20010323162956.A27066@ganymede.isdn.uiuc.edu>
 <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>
 <20010323235909.C3098@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:31 PM 3/23/01 -0800, you wrote:
>This has nothing to do with fastpathing and object code optimization. C
>doesn't have exception handling, so you either have to remember to undo
>allocations etc.  in failure cases all through the code, or you stick your
>undo code at the end of the function and have all failure cases jump to the
>relevant label.  It's not pretty, but it's much less error-prone e.g.

Really?  I have a "cleanup" function that can be called during failure 
cases (and success cases -- but you didn't mention that) so that the cost 
is very low and I don't have to code ANY labels.

But then again, I'm a double-pipe abuser, in that I tend to code "atomic" 
sequences as

if ((a) || (b) || (c) || (d) || (e) || (f) || (g) || ... ) { something 
failed}  else {it all worked!}

and make sure that the failure value is non-zero for each a, b, c, d, and 
so forth.

I remember looking at the generated code from one compiler for x86 and 
seeing a series of short jumps to short jumps to short jumps... to the 
failure case, which in that particular sequence saved about 100 bytes.  I 
haven't looked at GCC output yet to see what it does, but working in a 
32-bit system instead of a 16-bit system I tend to care a little less about 
"efficiency".

Does that mean that I avoid "goto"?  No. Like every other construct in the 
C language, there is a valid and appropriate use for every single 
thing.  The key is recognizing when the goto is appropriate.

Another thing you will see in my code is resource pointers being 
initialized to zero on entry, set to non-zero values as resources are 
allocated, and then conditionally released based on whether the value is 
zero or non-zero.  It makes recovery from malloc failures easier, for one 
thing.

Satch. the || Abuser.

