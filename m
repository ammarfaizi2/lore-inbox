Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267357AbUH1HXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUH1HXy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 03:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUH1HXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 03:23:54 -0400
Received: from tanthi.teneoris.com ([164.164.94.19]:24261 "EHLO
	tanthi.teneoris.com") by vger.kernel.org with ESMTP id S267357AbUH1HXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 03:23:51 -0400
Subject: timer_create not working in 2.6.5
From: Amol <amol@teneoris.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093677537.3479.84.camel@amol.teneoris.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 12:48:57 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 My system has fedora-core-2. I tried to run this small program to
create a posix time but it seems it is giving me wrong timer-id.. some
garbage number. Finally program segfaults in timer_settime( not included
here)

Any clues ?
Please CC me
Amol

--------------

#include <time.h>
#include <signal.h>
#include <unistd.h>

void timer_handler(int signo, siginfo_t *info, void *context)
{
        printf("got signal..\n");
}

int main(){
        struct timespec ts, tm, sleep;
        sigset_t mask;
        siginfo_t info;
        struct sigevent sigev;
        struct sigaction sa;
        struct itimerspec ival;
        timer_t tid;

        sigemptyset(&mask);
        sigprocmask(SIG_SETMASK, &mask, NULL);

        sa.sa_flags = SA_SIGINFO;
        sigemptyset(&sa.sa_mask);
        sa.sa_sigaction = timer_handler;

        if (sigaction(SIGRTMIN, &sa, NULL) == -1) {
                perror("sigaction failed");
                return -1;
        }

        sigev.sigev_notify = SIGEV_SIGNAL;
        sigev.sigev_signo = SIGRTMIN;
        sigev.sigev_value.sival_int = 1;

        if (timer_create(CLOCK_MONOTONIC, &sigev, &tid) == -1){
                perror("timer_create");
                return -1;
        }
        printf("timer-id = %d\n", tid);
}


