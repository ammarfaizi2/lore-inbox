Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271842AbRHUTtD>; Tue, 21 Aug 2001 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271843AbRHUTsx>; Tue, 21 Aug 2001 15:48:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8324 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271842AbRHUTsq>; Tue, 21 Aug 2001 15:48:46 -0400
Date: Tue, 21 Aug 2001 15:48:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: SCHED_RR
Message-ID: <Pine.LNX.3.95.1010821154223.31909A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To whomever said that sched RR doesn't work, I added some diagnostics
to your code and it seems to work okay with linux 2.4.1.



#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<sched.h>


int main()
{
    struct sched_param sp;
    int ch, pr;
    ch = pr = 0;
    memset(&sp, 0x00, sizeof(sp));
    sp.sched_priority = 1;
    sched_setscheduler(0, SCHED_RR, &sp);

    if(fork() == 0) {
        while(1) {
            ch++;
            printf(" child %d\n", ch);
            sched_yield();
        }
    }
    else {
        while(1) {
            pr++;
            printf("parent %d\n", pr);
            sched_yield();
        }
    }
    return 0;
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


