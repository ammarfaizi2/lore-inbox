Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRCBFag>; Fri, 2 Mar 2001 00:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbRCBFa0>; Fri, 2 Mar 2001 00:30:26 -0500
Received: from f104.law14.hotmail.com ([64.4.21.104]:43022 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130329AbRCBFaI>;
	Fri, 2 Mar 2001 00:30:08 -0500
X-Originating-IP: [212.46.203.217]
From: "John Being" <olonho@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: olonho@hotmail.com
Subject: strange nonmonotonic behavior of gettimeoftheday
Date: Fri, 02 Mar 2001 05:30:02 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F104TJcu8Puwo7hGP4E00009f3d@hotmail.com>
X-OriginalArrivalTime: 02 Mar 2001 05:30:02.0497 (UTC) FILETIME=[D49BFF10:01C0A2D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got following problem with 2.2.17 (Redhat stock kernel)
Linux ***** 2.2.17-14 #1 Mon Feb 5 14:57:25 EST 2001 i586 unknown
on AMD K6,  VIA Technologies VT 82C586, Compaq Presario XL119.
Following C program
#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>
#include <time.h>
#define ABS(x) (x < 0 ? -x : x)
#define TIME_T struct timeval
#define TIME_DIFF_T long
#define GET_TIME(x) gettimeofday(&x, NULL)
#define TIME_DIFF(x1, x2) ((x2.tv_sec - x1.tv_sec)*1000000 + (x2.tv_usec - 
x1.tv_usec))
int main(int argc, char** argv)
{
   TIME_T t1, t2;
   TIME_DIFF_T d;

   GET_TIME(t2);
   while (1) {
     GET_TIME(t1);
     d = TIME_DIFF(t2, t1);
     if (d > 500000 || d < 0) {
             fprintf(stderr, "Leap found: %ld msec\n", d);
             return 0;
     }
     t2 = t1;
   }
return 1;

gives following result on box in question
root@******:# ./clo
Leap found: -1687 msec
and prints nothing on all other  my boxes.
This gives me bunch of troubles with occasional hang ups and I found nothing 
in kernel archives at 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
just some notes about smth like this for SMP boxes with ntp. Is this issue 
known, and how can I fix it?

  Thanks.


_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

