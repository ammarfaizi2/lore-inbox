Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131026AbRBCWyF>; Sat, 3 Feb 2001 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBCWx4>; Sat, 3 Feb 2001 17:53:56 -0500
Received: from [63.89.188.10] ([63.89.188.10]:10761 "EHLO xchange.zambeel.com")
	by vger.kernel.org with ESMTP id <S131026AbRBCWxo>;
	Sat, 3 Feb 2001 17:53:44 -0500
From: Mohit Aron <aron@Zambeel.com>
To: linux-kernel@vger.kernel.org
Message-Id: <200102032253.OAA08890@mohit-linux.zambeel.com>
Subject: system call sched_yield() doesn't work on Linux 2.2
Date: Sat, 3 Feb 2001 14:53:26 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.8886.981240806--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.8886.981240806--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
	the system call sched_yield() doesn't seem to work on Linux 2.2. Does
anyone know of a kernel patch that fixes this ? 

Attached below is a small program that uses pthreads and demonstrates that
sched_yield() doesn't work. Basically, the program creates two threads that
alternatively try to yield CPU to each other.


- Mohit


--%--multipart-mixed-boundary-1.8886.981240806--%
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sched_yield.c"

#include <stdio.h>
#include <sched.h>
#include <pthread.h>

static pthread_t thread1, thread2;


static void *thread1_func(void *arg)
{
  int i;

  for (i=0; i < 5 ;i++) {
    printf("Thread1\n");
    if (sched_yield()) printf("error in yielding\n");
  }
}

static void *thread2_func(void *arg)
{
  int i;

  for (i=0; i < 5 ;i++) {
    printf("Thread2\n");
    if (sched_yield()) printf("error in yielding\n");
  }
}


int main(int argc, char **argv)
{
  pthread_create(&thread1, NULL, thread1_func, NULL);
  pthread_create(&thread2, NULL, thread2_func, NULL);

  sleep(10);

  return 0;
}

--%--multipart-mixed-boundary-1.8886.981240806--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
