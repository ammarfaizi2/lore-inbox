Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRCBPHz>; Fri, 2 Mar 2001 10:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRCBPHo>; Fri, 2 Mar 2001 10:07:44 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:57330 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129212AbRCBPHf>; Fri, 2 Mar 2001 10:07:35 -0500
Message-ID: <3A9FB734.6912206F@inet.com>
Date: Fri, 02 Mar 2001 09:07:32 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Being <olonho@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday
In-Reply-To: <F104TJcu8Puwo7hGP4E00009f3d@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Being wrote:
> 
> I've got following problem with 2.2.17 (Redhat stock kernel)
> Linux ***** 2.2.17-14 #1 Mon Feb 5 14:57:25 EST 2001 i586 unknown
> on AMD K6,  VIA Technologies VT 82C586, Compaq Presario XL119.
> Following C program
> #include <stdio.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <time.h>
> #define ABS(x) (x < 0 ? -x : x)
> #define TIME_T struct timeval
> #define TIME_DIFF_T long
> #define GET_TIME(x) gettimeofday(&x, NULL)
> #define TIME_DIFF(x1, x2) ((x2.tv_sec - x1.tv_sec)*1000000 + (x2.tv_usec -
> x1.tv_usec))
> int main(int argc, char** argv)
> {
>    TIME_T t1, t2;
>    TIME_DIFF_T d;
> 
>    GET_TIME(t2);
>    while (1) {
>      GET_TIME(t1);
>      d = TIME_DIFF(t2, t1);
>      if (d > 500000 || d < 0) {
>              fprintf(stderr, "Leap found: %ld msec\n", d);
>              return 0;
>      }
>      t2 = t1;
>    }
> return 1;
> 
> gives following result on box in question
> root@******:# ./clo
> Leap found: -1687 msec
> and prints nothing on all other  my boxes.
> This gives me bunch of troubles with occasional hang ups and I found nothing
> in kernel archives at
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
> just some notes about smth like this for SMP boxes with ntp. Is this issue
> known, and how can I fix it?

(That should read "usec" since you are printing microseconds and not
milliseconds.)

I've seen behaviour like that on an ARM processor because the time code
was not considering missed (or rather, delayed response to) timer
interrupts.  The time jump in that case was slightly less than 1 jiffie
(jiffie = 10ms).  It's likely rather hardware specific; see if you can
get someone with the same hardware to run your test code.

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
