Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWCCKgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWCCKgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCCKgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:36:37 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:51708 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751336AbWCCKgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:36:37 -0500
Message-ID: <44081BCD.3040502@metro.cx>
Date: Fri, 03 Mar 2006 11:34:53 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Dooks <ben-linux-arm@fluff.org>
CC: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] s3c2412 support
References: <44045B98.8010405@metro.cx> <20060301091035.GB26072@trinity.fluff.org>
In-Reply-To: <20060301091035.GB26072@trinity.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:

>It would help to split these emails into smaller chunks than all the files
>so that comments could be with the chunks that it goes with.
>  
>
All right, i'll repost in a minute..

>Makefile.diff	- going to have to remove those #s at somepoint
>  
>
True, but i can't submit those as long as i use tomtom specific cpu-type 
registers (see reply to other post later today).

>regs-clock.diff - didn't need to add s3c2412_get_pll, same as s3c2410_get_pll 
>  
>
Hmm, i disagree.. The term (mdiv+8) is multiplied by 2 for s3c2412, this 
is not the case for s3c2410..
I changed it to use the 64 bit arithmetic like s3c2410_get_pll and 
you'll notice the difference is this line:

+       fvco = (uint64_t)baseclk * ((mdiv + 8)<<1);

Maybe it is better to use one get_pll and add an extra parameter to 
indicate the multiplication of (mdiv+8) ?

>regs-gpio.diff	- group the s3c2412 changes together into larger #ifdefs
>  
>
Done.

>regs-rtc.diff	- two sets of changes here? 2410 and 2412 additions
>  
>
Ok, cleaned that up..

>cpu.diff:
>
>the 2412 is an ARM926EJS, so I'd expect the core-ID accessed
>via the co-processor registers to be diffeernt, so this could give
>the indication of what sort of CPU to try.
>
>this also seems to have the S3C2442 ID patch from the patch-q in it,
>please be careful about merging patches like that.
>  
>
Ok, cleaned that up a bit too.. As for the core-ID remark, i will try 
and have a look at it today, but as it is my last day at this firm today 
i can't make any guarantees. Maybe Dimitry Andric will pick this up when 
i'm gone..

Best,

Koen

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

