Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbRAKMU3>; Thu, 11 Jan 2001 07:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130856AbRAKMUU>; Thu, 11 Jan 2001 07:20:20 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:48400 "HELO
	smtp.pandora.be") by vger.kernel.org with SMTP id <S130217AbRAKMUN>;
	Thu, 11 Jan 2001 07:20:13 -0500
Date: Thu, 11 Jan 2001 13:20:17 +0100
From: mo6 <sjoos@pandora.be>
To: Robert Kaiser <rob@sysgo.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Message-ID: <20010111132017.A27515@pandora.be>
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org> <01010922264400.02737@rob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <01010922264400.02737@rob>; from rob@sysgo.de on Tue, Jan 09, 2001 at 10:17:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 10:17:47PM +0100, Robert Kaiser wrote:
> On Die, 09 Jan 2001 you wrote:
> > Robert Kaiser wrote:
> > > if someone had pressed the reset button. The same kernel boots fine on
> > > 486 and Pentium Systems.
> > > 
> > > Any ideas/suggestions ?
> > 
> > 
> > is "Checking if this processor honours the WP bit even in supervisor
> > mode... " the last thing you see before the reset?
> > 
> 
> No, I don't see _any_ messages from the kernel. The last thing I see is
> "Uncompressing Linux... Ok, booting the kernel." I have added some
> quick and dirty debug code that writes messages directly to the VGA
> screen buffer. According to that, execution seems to get as far as the
> statement
> 
>         *pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> 

Changing the 
	if( end && (vaddr >= end))
		break;
just before that snippet of yours (I believe it's on lines 379-380) into
	if (vaddr >= end)
		break;
or alternatively adding
	if (!end)
		break;
between if(end &&...) break; and *pte = mk_...; produces a kernel bootable 
on 386.

With kind regards,

Sven Joos			    
-- 
If the odds are a million to one against something occurring, chances
are 50-50 it will.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
