Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUEaGNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUEaGNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUEaGNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:13:30 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:9933 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S264531AbUEaGN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:13:28 -0400
Message-ID: <40BACD01.5000106@bigpond.net.au>
Date: Mon, 31 May 2004 16:13:21 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: ndiamond@despammed.com, linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
References: <200405310250.i4V2ork05673@mailout.despammed.com> <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au>
In-Reply-To: <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
> On Sun, 30 May 2004 ndiamond@despammed.com wrote:
> 
> 
>>Yes, if we use a real-time Linux and make a daemon cooperate very closely
>>with the driver.
>>
>>
>>>Maybe you could use lookup tables instead of doing floating point
>>>arithmetic.
>>
>>You might be right, if the device can only be controlled to position itself
>>in say 1,000 different ways, then we could have lookup tables for 1,000
>>different intervals of (emulations of) floating-point numbers, that yield
>>1,000 different values of sin.  Another table for cos, another for log10,
>>etc.  But I'd still have to write my own emulations for binary operators
>>such as +, /, etc., since a 1,000*1,000 lookup table would be too big.
> 
> 
> Why not scaled longs (or bigger), scalled to number of significant 
> digits. The Taylor series for the trig functions might be a painfull.

See the "Handbook of Mathematical Functions" by Abromawitz and Stegun, 
Dover Publications (ISBN 486-61272-2, Library of Congress number 
65-12253) which has some small but accurate polynomial approximations 
for many functions.  I have used these successfully with fixed point 
rational numbers (FDRN) (which are probably the same as your scaled 
longs) using 64 bit integers and the results were generally accurate to 
the least significant bit when compared to values calculated using the 
normal maths library and converted to FDRN representation.

Of course, the available range of values is smaller than for floats or 
double and you have to be careful w.r.t. overflow etc.

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

