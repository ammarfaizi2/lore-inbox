Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKALKK>; Thu, 1 Nov 2001 06:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278700AbRKALJu>; Thu, 1 Nov 2001 06:09:50 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:49413 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S278697AbRKALJj>; Thu, 1 Nov 2001 06:09:39 -0500
Message-ID: <3BE12D46.780477E@idb.hist.no>
Date: Thu, 01 Nov 2001 12:08:54 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   . It's
> 
> here's my munge of the same data:
>         http://mhahn.mcmaster.ca/~hahn/foo.png
> the measures I find interesting are the SI/SO rates.  first, the most obvious
> feature is that Rik-VM has a serious problem knowing when to *stop* swapping
> out.  but SO isn't a bad thing unless it's obsessive: it's when you see high
> *swap-in* that you know the VM has previously chosen bad pages to SO.

Sure.  SO isn't bad for the benchmark, but think of the guy trying 
to use the machine after the test finished.  It probably swapped out
a lot of other processes which is why you didn't see it swap in again.
These things weren't needed for the bench, but daily use don't
look like that.  If my big job takes a long time - no problem
if I can work on something else with nice performance.

> and this is the second big difference: Rik-VM doesn't make nearly as many
> mistakes - especially look at Andrea-VM thrashing out-in-out at ~ samples 26-32.
> 
> also, if you merely sum the SI and SO columns for each:
>                 sum(SI)         sum(SO)         sum(SI+SO)
>       Rik-VM    43564           317448          290032
>       AA-VM     118284          171748          361012
> to me, this looks like the same point: Rik being SO-happy,
> Andrea having to SI a lot more.  interesting also that Andrea wins the race,
> in spite of poorer SO choices and more swap traffic overall.

It'd be real interesting to know wether or not the "excessive" swapping 
caused extra seeks. Readahead or simply reading more consecutive blocks 
don't hurt - while seeks do.  Perhaps this is why it didn't hurt so
much?

Also consider the multiuser aspect - punishing a memory pig with
extra swapin isn't necessarily so bad, if it keeps more memory around
for others.  Could possibly be bad for a dedicated box, but Andrea won 
on speed anyway.

Helge Hafting
