Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135782AbREBUxk>; Wed, 2 May 2001 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbREBUxe>; Wed, 2 May 2001 16:53:34 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:31622 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S135782AbREBUxL>; Wed, 2 May 2001 16:53:11 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Kernel doesn't create core for threads
Message-ID: <3AF073AC.AE48BB78@i.am>
Date: Wed, 2 May 2001 20:53:00 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1-RTL3.0 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Looks to me like the latest 2.4.5-pre1 is not creating
coredump for multithreaded aplications:

----
$ ulimit  -a
core file size (blocks)     unlimited
data seg size (kbytes)      unlimited
file size (blocks)          unlimited
max locked memory (kbytes)  unlimited
max memory size (kbytes)    unlimited
open files                  1024
pipe size (512 bytes)       8
stack size (kbytes)         8192
cpu time (seconds)          unlimited
max user processes          6144
virtual memory (kbytes)     unlimited

$ ./testcore 
Segmentation fault


--- test program --

#include <stdio.h>
#include <pthread.h>

#define TASKS 10

void* thread(void* arg)
{
    printf("yuk %s\n", 0xffff0000);
    return 0;
}

int main(int argc, char *argv[])
{
    pthread_t task[TASKS];
    void* ret;
    int i = 0;
    for(i = 0; i < TASKS; i++)
	pthread_create(&task[i], NULL, thread, 0);
    for(i = 0; i < TASKS; i++)
	pthread_join(task[i], &ret);

    return 0;
}
---


for single threadad apps there is no problem:
(just put printf after int i declaration)
$ ./testcore 
Segmentation fault (core dumped)

---

Am I doing something wrong ???

Also for quite a long time Alan's AC patches were efictively locking
my machine when threaded application was crashing - resolvin
almost original behaviour solved this problem - but I like 
per-thread coredump - is there any special reason why this is still
not present in the current 2.4.4 kernel as I can see this as quite
usefull.


bye


kabi@i.am

