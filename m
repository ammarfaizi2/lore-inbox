Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRCBWdz>; Fri, 2 Mar 2001 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129594AbRCBWdr>; Fri, 2 Mar 2001 17:33:47 -0500
Received: from f280.law14.hotmail.com ([64.4.20.155]:22534 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129581AbRCBWdc>;
	Fri, 2 Mar 2001 17:33:32 -0500
X-Originating-IP: [212.46.197.1]
From: "John Being" <olonho@hotmail.com>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday
Date: Fri, 02 Mar 2001 22:33:25 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F280ueD0WeOnFl0YldT00002135@hotmail.com>
X-OriginalArrivalTime: 02 Mar 2001 22:33:26.0118 (UTC) FILETIME=[CC050060:01C0A368]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, short status from the same box. It was up for about 2 weeks, but
yesterday due this problem it become unuseable, as X failed at startup with 
message about failed select(). Before reboot I made some tests
and found:
- it triggered by starting of X (without X no backjumps)
- it has something with interrupts, at least when I run program above
    (it is correct, at least it can determine problem) as
    while [ 1 ]; do ./clo; done
    and pressed key, it printed much less strings
- jumps are about 300-2000 microseconds
- there are some cases of such behaviour on Usenet (mainly diagnosed as 
screen  flickering due incorrect  screensaver startup)


After reboot problem goes away( nothing changed in config). Maybe it related 
to APM (as I did several suspends before this problem appears). Program 
testing RDTSC works OK now. If this problem appears again - I will run it.
  Thanks for help.


>From: Manfred Spraul <manfred@colorfullife.com>
>To: olonho@hotmail.com
>CC: linux-kernel@vger.kernel.org
>Subject: Re: strange nonmonotonic behavior of gettimeoftheday
>Date: Fri, 02 Mar 2001 18:06:05 +0100
>
> >
> > on AMD K6, VIA Technologies VT 82C586, Compaq Presario XL119.
> > [snip]
> > gives following result on box in question
> > root@******:# ./clo
> > Leap found: -1687 msec
> > and prints nothing on all other my boxes.
>
>Perhaps APM or SMI problems?
>Could you run the attached program?
>
>--
>	Manfred
>#include <stdio.h>
>#include <sys/time.h>
>#include <unistd.h>
>#include <time.h>
>
>static unsigned long long get_tsc(void)
>{
>     	unsigned long v1;
>	unsigned long v2;
>	__asm__ __volatile__(
>		"rdtsc\n\t"
>		: "=a" (v1), "=d" (v2));
>	return (((unsigned long long)v2)<<32)+v1;
>}
>
>int main(int argc, char** argv)
>{
>	unsigned long long t1;
>	unsigned long long t2;
>
>	printf("RDTSC tester\n");
>	t1 = get_tsc();
>	for(;;) {
>		t2 = get_tsc();
>		if(t1 > t2) {
>			printf("tsc jumped backwards: from %lld to %lld.\n",
>					t1, t2);
>		}
>#if 0
>		printf("diff is %lld-%lld=%d.\n",t2,t1,t2-t1);
>#endif
>		t1 = t2;
>
>	}
>	return 1;
>}
>

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

