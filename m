Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSAYVpY>; Fri, 25 Jan 2002 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290820AbSAYVpO>; Fri, 25 Jan 2002 16:45:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290818AbSAYVpG>; Fri, 25 Jan 2002 16:45:06 -0500
Date: Fri, 25 Jan 2002 16:45:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Uptime again
Message-ID: <Pine.LNX.3.95.1020125164226.443A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just accidentally deleted all the messages about uptime including
the code sent to me to test to see if it was a user-mode problem.

It seems to be a user-mode problem:


Script started on Fri Jan 25 16:38:52 2002
# cat >xxx.c

#include <stdio.h>
#include <sys/sysinfo.h>

struct sysinfo info;
#define SECS_MIN 60
#define SECS_HR (SECS_MIN * 60)
#define SECS_DAY (SECS_HR * 24)

int main(void) {

        long uptime;
        long days, hrs, min, sec;


        sysinfo(&info);
        printf("uptime: %ld sec\n", info.uptime);

        uptime  = info.uptime;
        days    = info.uptime / SECS_DAY;
        uptime -= (days * SECS_DAY);
        hrs     = uptime / SECS_HR;
        uptime -= (hrs * SECS_HR);
        min     = uptime / SECS_MIN;
        sec     = uptime - (min * SECS_MIN);
        printf("uptime %ldd %02ld:%02ld:%02ld\n", days, hrs, min, sec);
        return(0);
}
^Z

# gcc -o xxx xxx.c
# ./xxx
uptime: 11153047 sec
uptime 129d 02:04:07
# ./xxx
uptime: 11153055 sec
uptime 129d 02:04:15
# exit
Script done on Fri Jan 25 16:39:27 2002


Hand-made 'uptime' shows more than 128 days.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


