Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUHTBvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUHTBvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUHTBvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:51:11 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:12951 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S265027AbUHTBvF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:51:05 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2
Date: Thu, 19 Aug 2004 21:51:00 -0400
User-Agent: KMail/1.6.82
Cc: vherva@viasys.com
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040819182752.GA3024@viasys.com> <200408191517.23082.gene.heskett@verizon.net>
In-Reply-To: <200408191517.23082.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408192151.01354.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 20:51:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 15:17, Gene Heskett wrote:
>On Thursday 19 August 2004 14:27, Ville Herva wrote:
[...]
>>Please try to find a stable configuration before reporting more
>> oopses. memtest86 (www.memtest86.org), cpuburn and memburn (use
>> google) should be of great help making sure the hardware is not
>> acting up.
[...]
I went after both, built them both and fired them off, cpuburn-in for 
2 hours that last time, and compiled memburn for half my ram or 
512kb.

Where memtest86-3.2a didn't find anything, this combination has twice 
found a bad memory location.

>From the first run, at round 81 over some half a gig, at 130017311 it 
got 7bf001f, expected 7bfe81f and reread it 3 times as 7bf001f.

On the next run, I started cpuburn first, and fired off memburn again, 
and got this:
Passed round 133, elapsed 4827.19.
FAILED at round 134/14208927: got ff00, expected 0!!!

REREAD: ff00, ff00, ff00!!!

So there is apparently something fubar someplace.  I've now recompiled 
it for testing 768 megs, and while that startup is normal, its also 
shoved 150 megs out to swap and the machine is lagging quite a bit.
cpuburn isn't running, according to the cpu temps, setiathome also 
does a fine job of that.  It also didn't take much time for memburn 
to exit with this:
[root@coyote memburn]# ./memburn
Starting test with size 768 megs..

Passed round 0, elapsed 44.36.
Passed round 1, elapsed 74.13.
Passed round 2, elapsed 105.12.
FAILED at round 3/25777183: got 2b00, expected 0!!!

REREAD: 2b00, 2b00, 2b00!!!

I just fixed the printf statement in memburn for a 8 digit hex output, 
seeing only 4 as above bothers me when I know the address being read 
is an 8 digit pointer to an 8 digit hex value.  I also fixed the 
scanf conversions use of the atoi so you can enter the value in 
megbytes without haveing to reset its default and recompile it.

Yeah, I know just enough C to be dangerous :)

I'm going to run this until I have enough data to point to the exact 
memory chip on these sticks if I can.  I'm also surprised that there 
has been no Oops while allocating 768 megs of ram to run this in.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
