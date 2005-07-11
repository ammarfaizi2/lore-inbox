Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGKK6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGKK6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGKK6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:58:17 -0400
Received: from us401.activeby.net ([216.32.91.22]:18890 "EHLO
	us401.activeby.net") by vger.kernel.org with ESMTP id S261162AbVGKK6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:58:15 -0400
Message-ID: <42D250C1.6070604@active.by>
Date: Mon, 11 Jul 2005 13:58:09 +0300
From: Rommer <rommer@active.by>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: fork() & setpriority()
Content-Type: multipart/mixed;
 boundary="------------030102000903020405020302"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - us401.activeby.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - active.by
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102000903020405020302
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have trouble with fork() and setpriority().
When priority of child process != priority of parent process
and used SIGCHLD handler.
See example.

kernel 2.6.12.1, no SMP

-- 
Best regards, Roman

--------------030102000903020405020302
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#include <sys/time.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

struct sigaction sa_chld;
int i = 0;


static void chld_handler (int signum) {
    int status = 0;
    wait (&status);
    printf ("child closed: status = %i\n", status >> 8);
}


void test (void) {
    pid_t pid = fork ();

    if (pid == 0) {
	setpriority (PRIO_PROCESS, 0, 0);
	printf ("helo from child, i = %i\n", i);
	exit (i);
    }
}


int main () {
    memset (&sa_chld, 0, sizeof (sa_chld));
    sa_chld.sa_handler = &chld_handler;
    sigaction (SIGCHLD, &sa_chld, NULL);

    setpriority (PRIO_PROCESS, 0, -1);
    while (1) {
	i++;
	test ();
	sleep (3);
    }
    return 0;
}

--------------030102000903020405020302--
