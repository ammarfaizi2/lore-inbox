Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCBRHD>; Fri, 2 Mar 2001 12:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129323AbRCBRGx>; Fri, 2 Mar 2001 12:06:53 -0500
Received: from colorfullife.com ([216.156.138.34]:47621 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129321AbRCBRGp>;
	Fri, 2 Mar 2001 12:06:45 -0500
Message-ID: <3A9FD2FD.8D80E684@colorfullife.com>
Date: Fri, 02 Mar 2001 18:06:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: olonho@hotmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday
Content-Type: multipart/mixed;
 boundary="------------BB5831E01C8A4E1D0B0CD7DA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BB5831E01C8A4E1D0B0CD7DA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>
> on AMD K6, VIA Technologies VT 82C586, Compaq Presario XL119. 
> [snip]
> gives following result on box in question 
> root@******:# ./clo 
> Leap found: -1687 msec 
> and prints nothing on all other my boxes. 

Perhaps APM or SMI problems?
Could you run the attached program?

--
	Manfred
--------------BB5831E01C8A4E1D0B0CD7DA
Content-Type: text/plain; charset=us-ascii;
 name="ms.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ms.c"

#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>
#include <time.h>

static unsigned long long get_tsc(void)
{
    	unsigned long v1;
	unsigned long v2;
	__asm__ __volatile__(
		"rdtsc\n\t"
		: "=a" (v1), "=d" (v2));
	return (((unsigned long long)v2)<<32)+v1;
}

int main(int argc, char** argv)
{
	unsigned long long t1;
	unsigned long long t2;

	printf("RDTSC tester\n");
	t1 = get_tsc();
	for(;;) {
		t2 = get_tsc();
		if(t1 > t2) {
			printf("tsc jumped backwards: from %lld to %lld.\n",
					t1, t2);
		}
#if 0
		printf("diff is %lld-%lld=%d.\n",t2,t1,t2-t1);
#endif
		t1 = t2;
	
	}
	return 1;
}


--------------BB5831E01C8A4E1D0B0CD7DA--


