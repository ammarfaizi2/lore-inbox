Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312717AbSCVPbQ>; Fri, 22 Mar 2002 10:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312716AbSCVPbI>; Fri, 22 Mar 2002 10:31:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312718AbSCVPaz>; Fri, 22 Mar 2002 10:30:55 -0500
Date: Fri, 22 Mar 2002 10:31:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Bad VM-86 in Linux version 2.4.18
Message-ID: <Pine.LNX.3.95.1020322101831.892A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VM86 gurus,

The following won't run in DOS (VM86) anymore. This is compiled
using MS C600 dos compiler and it used to run, both in DOS and
in Linux. It still runs in Linux:

--------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>
#include <math.h>

#define MAX_FLOAT 0x2000

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
        fprintf(stderr,".");
    }
    fprintf(stderr, "Floating point failure\n");
    return 1;
}
--------------------

The VM86 error(s), are (hand-copied):

ERROR: unexpected CPU exception 0x06 errorcode: 0x00000000 while in vm86 (DOS)
[00021963]
Program=sigsegv.c, Line=246
[00021963] EIP: 0be3:0000638f ESP: 11c6:00001262 VFLAGS(b): 00000 00111010
 1000011
EAX: 00048748 EBX: 000024b0 ECX: 00000000 EDX: 000003bc VFLAGS(h): 00003a87
ESI: 0000bc57 EDI: 0000002e EBP: 00000094 DS: 11c6 ES: 1262 FS: 0000
 GS: 0000
[00021963] FLAGS: CF PF SF IF OF RF VM VIF IOPL:3
[00021964] STACK: 6e 12 fe 2f 94 00 c6 11 62 12 -> 72 12 00 3c 78 13 70 12 02 00
[00021964] OPS: 00 48 1b 34 19 6d 17 6e 1b 05 -> 63 6f 74 61 6e 00 00 00 04 00
	636f74		0be3:638f arpl	[bx+74],bp


The old-fashioned DOS/Real-mode C-compiler does not "know" any funny
op-codes. It thinks everything is a '486 with a FPU unit. The code
works fine if I boot DOS from the start, not in the VM86 environment.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

