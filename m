Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289833AbSAPWF3>; Wed, 16 Jan 2002 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSAPWFR>; Wed, 16 Jan 2002 17:05:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49281 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289920AbSAPWEY>; Wed, 16 Jan 2002 17:04:24 -0500
Date: Wed, 16 Jan 2002 17:05:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Christian Thalinger <e9625286@student.tuwien.ac.at>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: floating point exception
In-Reply-To: <3C45F7B6.1BCB4519@didntduck.org>
Message-ID: <Pine.LNX.3.95.1020116170247.15437A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Brian Gerst wrote:

> "Richard B. Johnson" wrote:
> > 
> > On 16 Jan 2002, Christian Thalinger wrote:
> > 
> > > On Wed, 2002-01-16 at 15:32, Zwane Mwaikambo wrote:
> > > > Can you also reproduce _without_ loading NVdriver, just to make everybody
> > > > happy.
> > > >
> > > > Thanks,
> > > >     Zwane Mwaikambo
> > > >
> > >
> > > Sure, same breakdown. Maybe it's really an dual athlon xp issue as dave
> > > jones mentioned. But shouldn't this also occur when i trigger a floating
> > > point exception myself? Is there a way to check which floating point
> > > exception was raised by the seti client?
> > >
> > > Regards.
> > >
[SNIPPED...]



> > into one array. Then you do the exact same thing with the results
> > put into another array.  Then just `memcmp` the arrays! You run
> > this in a loop for an hour. If the kernel is mucking with your FPU,
> > it will certainly show.
> 
> Hmm, that's an interesting idea... An Athlon optimised kernel does use
> the MMX/FPU registers to do mem copies.  Try running a kernel compiled
> for just a Pentium and see if the problem persists.
> 

Here's a progy.. This SHOULD run forever. I assume malloc() works and
don't check the result --yes I already know that.


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>
#include <math.h>

#define MAX_FLOAT 0x100000

int main(int args, char *argv[])
{
    unsigned int seed;   
    double *x;
    double *y;
    double *z;
    size_t i;
    x = (double *) malloc(MAX_FLOAT * sizeof(double));
    y = (double *) malloc(MAX_FLOAT * sizeof(double));
    (void) time((time_t *)&seed);
    for(;;)
    {
        srand(seed); 
        z = x;
        for(i = 0; i < MAX_FLOAT; i++)
            *z++ = cos((double) rand());
        srand(seed);
        z = y;
        for(i = 0; i < MAX_FLOAT; i++)
            *z++ = cos((double) rand());
        if(memcmp(x, y, MAX_FLOAT * sizeof(double)))
            break;
        seed = rand();
    }
    fprintf(stderr, "Floating point failure\n");
    return 1;
}



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


