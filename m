Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCQOWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUCQOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:22:12 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:13803 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261479AbUCQOWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:22:06 -0500
Subject: Scheduler Problem ????
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1079533212.25474.370.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 15:20:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am running a 2.6.4 (with preemptible kernel activated). 
What I did is the following:

1) Compile the sched_test.c program (at the end of the mail):

[root@hermes sched]$ gcc -o sched_test sched_test.c

2) Set the priority of the root shell as the highest:
[root@hermes sched]$ ps
  PID TTY          TIME CMD
 1519 pts/0    00:00:00 bash
 2020 pts/0    00:00:00 ps
[root@hermes sched]$ chrt -f -p 99 1519

3) Run sched_test:
[root@hermes sched]$ chrt -f 10 ./sched_test 100
bye now.
  


Here during the execution of sched_test everything is frozen.


Did I do something wrong ????

sched_test.c
=============
#include <sys/time.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  int end_time;
  struct timeval now;

  if (argc < 2) 
    {
      end_time = 1;
    }
  else
    {
      end_time = atoi(argv[1]);
    }

  gettimeofday(&now, NULL);

  end_time += now.tv_sec + 1;

  do{
    gettimeofday(&now, NULL);
    
  }while (now.tv_sec < end_time);

  printf("bye now.\n");
  return 0;
}
==========

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

