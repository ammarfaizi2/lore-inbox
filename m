Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSAZP4P>; Sat, 26 Jan 2002 10:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSAZP4F>; Sat, 26 Jan 2002 10:56:05 -0500
Received: from mail5.ntplx.net ([204.213.176.70]:11407 "EHLO mail.ntplx.net")
	by vger.kernel.org with ESMTP id <S285229AbSAZPzw>;
	Sat, 26 Jan 2002 10:55:52 -0500
Message-ID: <3C52CFE3.2080107@ntplx.net>
Date: Sat, 26 Jan 2002 10:48:51 -0500
From: Ben Bridgwater <bennyb@ntplx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Stevens wrote:

 > Granted.  "if (x)" is true if "x" is non-zero, regardless of type and
 > shoudn't even generate a warning if "x" is scalar.

Surely the major point of using the compiler's _Bool would be for type 
safety -  if you only want readability then you may as well just use:

enum bool {true = 1, false = 0};

Now since C has historically utilized integer expressions for 
conditionals (with 0, !0 truth semantics), so it would be obnoxious to 
*unconditionally* make if (x) where x is non _Bool generate warnings, 
but IMO the whole point of using _Bool would be to then choose to turn 
on warnings for non _Bool conditionals, and to suppress warnings one 
would then need to be explicit about intentions by writing code such as:

if ((_Bool) (x = y)) ;

and hopefully if one accidently wrote:

if ((_Bool) x = y) ; /* int x, y */

then the compiler would warn that you probably didn't really mean that, 
since it means:

if ((_Bool) (x = (int) (_Bool) y)) ;

Which would have converted your y to _Bool (0/1) before assigning it to x.

Ben

P.S. I'm not on the list - please CC any response to me if you want a reply.

