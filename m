Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUELV2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUELV2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUELV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:28:48 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:22011 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S265239AbUELV20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:28:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Wed, 12 May 2004 17:28:22 -0400
User-Agent: KMail/1.6
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <008201c437e7$b1a35160$6601a8c0@northbrook> <20040512185224.GA2658@bounceswoosh.org>
In-Reply-To: <20040512185224.GA2658@bounceswoosh.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405121728.22629.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.63.246] at Wed, 12 May 2004 16:28:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 May 2004 14:52, Eric D. Mudama wrote:
>On Wed, May 12 at  0:09, Robert Hancock wrote:
>>If this is indeed the case, that those drives don't support the
>> "flush write cache" command, I'd like to see Maxtor's excuse as to
>> why.. I believe that Windows always powers down IDE drives before
>> shutdown, maybe this is because of non-universal support for the
>> "flush write cache" command?
>
>The issue is a bit more subtle, and I'm not making an "excuse" per
>say...
>
>(Not speaking officially for Maxtor, but I'm just trying to help...)
>
>
>As per the email I got from Bart, the drive in question doesn't
>support 48-bit commands.  The wierdness is that it claims to support
>the FLUSH CACHE EXT (0xEA) command.  Obviously, this combination
>doesn't make it safe to issue FLUSH CACHE EXT since the drive will
> not be able to properly report a failing location in the event of a
> failure to flush due to a fatal write fault.  The drive knows a
> FLUSH CACHE EXT command isn't safe, so it aborts that command which
> is the error message you see.
>
>The code that Bart showed me does a '&' on the feature word with the
>required support bits, but uses the result in an 'if' conditional. 
> I believe that means that in C, if either of the bits is set, then
> the 'if' will evaluate to true, which is causing the problem.
>
>The solution (that should work for all drives) would be to test
>properly to make sure the drive reports support for both 48-bit
>commands and FLUSH CACHE EXT, with something like:
>
>  if ((feature & bits) == bits)
>
>then issue that command.  If *either* of these bits is false, then
> the drive should be issued a normal FLUSH CACHE (0xE7) command
> (which is a reasonably standard 28-bit command, and all Maxtor
> drives support, including the models in question.)
>
>Note that this only affects newer drives (last 18 months or so) that
>are <120GB. (Yes, I know that is still a truckload)
>
>There are a gazillion of these in the field (we sell ~60 million
>drives/year?) so I don't believe a firmware "upgrade" or equivalent
>simply is logistically possible, but this inconsistency is going to
> be addressed in future products, I'm making sure of it.
>
>
>If anyone has questions, please don't hesitate to email and I'll do
> my best to help.

Thank you Eric, for such a clear explanation of the problem (I have 
one of those drives and was the one who made the second report I 
believe...  Now it seems that a fix can be written into our driver 
without a lot of fuss, so it becomes a non-issue for us once thats 
filtered thru Andrew and on up to Linus.

My Q for you, is, does M$ already have a similar workaround in their 
drivers?  Just curious. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
