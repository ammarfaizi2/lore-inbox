Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRK2UbA>; Thu, 29 Nov 2001 15:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283277AbRK2Ual>; Thu, 29 Nov 2001 15:30:41 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:17929 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S283267AbRK2Uac>; Thu, 29 Nov 2001 15:30:32 -0500
Message-Id: <200111292030.fATKU1s05921@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=US-ASCII
From: space-00002@vortex.physik.uni-konstanz.de
Organization: Universitaet Konstanz/Germany
To: linux-kernel@vger.kernel.org
Subject: buffer/memory strangeness in 2.4.16
Date: Thu, 29 Nov 2001 21:39:16 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com>
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing a bit of strange system behaviour in a vanilla 2.4.16 
kernel (2.95.3, very stable machine etc.)

I noticed, that after running for a while (day) I had significantly less 
memory available for my simulation program than right after booting. Looking 
at the problem using 'xosview' (or 'free'), I noticed that there was a large 
number of MBs filled with 'buffers' that did not get wiped when other 
programs need the memory. The system seems to rather kill an 'offender' than 
clean out buffers.

Right after booting, I can allocate about 650MBs memory using the little 
program attached below. After a day (or after running updatedb), under the 
same conditions, even in single user mode with only a shell running (!) this 
is not possible anymore and the program (below), trying to allocate only 
300-400MBs, gets killed by the system after making it unresponsive for many 
seconds.

Apparently this problem occurs after running 'updatedb', which fills 'free 
memory' and generates lots of filled cache and buffers on my system.

This sort of behaviour must have been introduced after 2.4.13, which does not 
show these problems.

Please tell me if somebody needs more information to debug this, or if this 
behaviour is normal or expected. Please cc: me as I am only on lkml-digest.

Cheers
	Jan


P.S. All RAM slots are full, so please don't suggest buying more memory as a 
solution :^)

-------------------%<-----------------------

#include <stdio.h>
#define ONE_MEG 1024 * 1024

main ()
{
        long mem_avail = ONE_MEG;
        char *buf;
        char userchar = '@';
        int howmany;

        while (1)
        {
                printf ("Number of MBs to allocate? ");
                scanf ("%d", &howmany);
                printf ("Trying to allocate %ld bytes: ", mem_avail*howmany);

                getchar ();
                if ((buf = (char *) malloc ((size_t) mem_avail*howmany))){
                        printf (" success!\n");
                        printf ("Now filling it up...\n");
                        memset (buf, userchar, mem_avail * howmany);
                        printf ("Hit ENTER to free the memory.\n");
                        getchar ();
                        free (buf);
                } else {
                        printf (" failed :(\n");
                }
        }
}

-------------------%<-----------------------
