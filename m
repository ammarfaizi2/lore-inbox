Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289371AbSAJKOI>; Thu, 10 Jan 2002 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSAJKN7>; Thu, 10 Jan 2002 05:13:59 -0500
Received: from moutng1.kundenserver.de ([212.227.126.171]:26346 "EHLO
	moutng1.schlund.de") by vger.kernel.org with ESMTP
	id <S289371AbSAJKNs>; Thu, 10 Jan 2002 05:13:48 -0500
From: "Matthias Benkmann" <matthias@winterdrache.de>
To: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Jan 2002 11:13:53 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <3C3D7771.17083.27A755@localhost>
In-Reply-To: <200201100019.g0A0JOM32110@hyper.wm.sps.mot.com>
In-Reply-To: <20020110004952.A11641@werewolf.able.es> (jamagallon@able.es)
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2002, at 19:19, Peter Barada wrote:

> 
> >Even
> >
> >int	b;
> >volatile const int a = 5;
> >b = a - a;
> >
> >can not be optimized to 
> >
> >b = 0;
> 
> Until you define the scope of the variables, you can't make that
> assertion.  If the code is:
> 
> int b;
> volatile const a=5;
> void stuff()
> {
>   b = a - a;
> }
> 
> I can see how a can change in the midst of the execution since
> some other code has access to a since its global scope.
> 
> If the code is:
> 
> int b;
> void stuff()
> {
>   volatile const a=5;
> 
>   b = a - a;
> }
> 
> Then the code can be optimized to 'b = 0;' since nowhere in the scope
> of 'a' does anyone take its address(which would allow it to be changed).

I could have hardware attached directly to the data bus (a hardware 
debugger for instance) that watches for the value 5 to appear. This is 
beyond the knowledge of the compiler.

> 2) No one takes the address of b, so there is no way for any external
>    hardware/thread to modify b.

see above. You don't need to take the address to catch the variable 
access.
 
MSB

-- 
Who is this General Failure,
and why is he reading my disk ?

