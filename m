Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRKAG7r>; Thu, 1 Nov 2001 01:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278159AbRKAG7h>; Thu, 1 Nov 2001 01:59:37 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:41477 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278177AbRKAG72>; Thu, 1 Nov 2001 01:59:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Thu, 1 Nov 2001 01:59:27 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011101065933Z278177-17408+8722@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 01:23, Mark Hahn wrote:
> > Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   .
> > It's
>
> here's my munge of the same data:
> 	http://mhahn.mcmaster.ca/~hahn/foo.png
> the measures I find interesting are the SI/SO rates.  first, the most
> obvious feature is that Rik-VM has a serious problem knowing when to *stop*
> swapping out.  but SO isn't a bad thing unless it's obsessive: it's when
> you see high *swap-in* that you know the VM has previously chosen bad pages
> to SO. and this is the second big difference: Rik-VM doesn't make nearly as
> many mistakes - especially look at Andrea-VM thrashing out-in-out at ~
> samples 26-32.
>
> also, if you merely sum the SI and SO columns for each:
> 		sum(SI)		sum(SO)		sum(SI+SO)
>       Rik-VM	43564		317448		290032
>       AA-VM	118284		171748		361012
> to me, this looks like the same point: Rik being SO-happy,
> Andrea having to SI a lot more.  interesting also that Andrea wins the
> race, in spite of poorer SO choices and more swap traffic overall.

My guess is that rik's vm allocates memory too relaxed.  It quickly grabbed 
all the memory it thought it would need so it wouldn't have to waste time 
increasing or shrinking it (i guess that's why) and in doing so it started to 
strangle memory needed for other things, generally decreasing the overall 
performance of the system.  That could be why you see spikes increasing and 
decreasing rapidly in rik's vm allocation of swap.  He had allocated 
everything and needed to shrink it to make room for something else (actual 
generation of the kde window for kghostview?) which caused it to lose much 
time and any advantage it had gained by not making actual swap mistakes.  
AA's memory allocation is more minimalistic but it easily has room for the 
memory needed to render the kde window and all once processing the ps file 
was done.  This would also back up what i visually saw during the test.  
Rik's kernel got done the processing of the ps file before AA's did, but it 
was stuck at a frozen looking kghostview window with nothing inside it for a 
while before being able to actually render the contents.   AA's was able to 
render the contents almost immediately after the window showed up on the 
screen.  
