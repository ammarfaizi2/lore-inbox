Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312736AbSCVQA2>; Fri, 22 Mar 2002 11:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312738AbSCVQAK>; Fri, 22 Mar 2002 11:00:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312736AbSCVP75>; Fri, 22 Mar 2002 10:59:57 -0500
Date: Fri, 22 Mar 2002 11:00:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: FPU problems in VM86
Message-ID: <Pine.LNX.3.95.1020322105208.1346A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous message showed that a test program won't work
in VM86 anymore.

This is a "simplication" of the program that shows it's a problem
using the FPU:


#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <math.h>

#define MAX_FLOAT 0x2000

int main(int args, char *argv[])
{
    double *x, *y;
    size_t i;
    if((x = (double *) malloc(MAX_FLOAT * sizeof(double))) == NULL)
        exit(1);
    for(;;)
    {
        y = x;
        for(i = 0; i < MAX_FLOAT; i++)
        {
            fprintf(stderr, "About to perform cos()\n");
            *y++ = cos((double) rand());
            fprintf(stderr, "Okay that time...\n");
        }
    }
    return 1;
}
---------------------------

This shows that it runs for a few hundred cycles before generating
an OOPS. The failure seems to occur during some kind of disk access
although I am not sure. Basically, it will run until something
makes my SCSI disk(s) active. The OOPs is not logged (don't know
why), so it's not a chicken-egg problem.

Things that do not use the FPU unit in VM86 work fine. I can compile
DOS BIOS source-code which uses a lot of DOS-based tools. Everything
works as expected. However, any attempt to use the FPU fails. Also
the OOPs is different each time. Same code, same static DOS, but,
the OOPs shows different errors every time, even seg-faults.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

