Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSAPVYk>; Wed, 16 Jan 2002 16:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287881AbSAPVXX>; Wed, 16 Jan 2002 16:23:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45697 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287676AbSAPVV6>; Wed, 16 Jan 2002 16:21:58 -0500
Date: Wed, 16 Jan 2002 16:23:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: floating point exception
In-Reply-To: <1011212807.507.3.camel@sector17.home.at>
Message-ID: <Pine.LNX.3.95.1020116161110.15035A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2002, Christian Thalinger wrote:

> On Wed, 2002-01-16 at 15:32, Zwane Mwaikambo wrote:
> > Can you also reproduce _without_ loading NVdriver, just to make everybody 
> > happy.
> > 
> > Thanks,
> > 	Zwane Mwaikambo
> > 
> 
> Sure, same breakdown. Maybe it's really an dual athlon xp issue as dave
> jones mentioned. But shouldn't this also occur when i trigger a floating
> point exception myself? Is there a way to check which floating point
> exception was raised by the seti client?
> 
> Regards.
> 

Maybe you can run it off from gdb? Or `strace` it to a file? Usually
these things are caused by invalid 'C' runtime libraries, either
corrupt, "installed by just making a sim-link to something that
was presumed to be close to what the application was compiled with",
or an error in mem-mapping.

Another very-real possibility is that somebody used floating-point
within the kernel thus corrupting  the `seti` FPU state. You can
check this out by making a program that does lots of FP calculations,
perhaps the sine of a large number of values. You put the results
into one array. Then you do the exact same thing with the results
put into another array.  Then just `memcmp` the arrays! You run
this in a loop for an hour. If the kernel is mucking with your FPU,
it will certainly show.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


