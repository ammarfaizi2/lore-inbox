Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292939AbSCFQIN>; Wed, 6 Mar 2002 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292984AbSCFQIE>; Wed, 6 Mar 2002 11:08:04 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:61108 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S292939AbSCFQHy>; Wed, 6 Mar 2002 11:07:54 -0500
Message-ID: <3C8640C8.367A30BB@nortelnetworks.com>
Date: Wed, 06 Mar 2002 11:16:08 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <3C859007.50102@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> I have a program that I very often need to calculate the current
> time, with milisecond accuracy.  I've been using gettimeofday(),
> but gprof shows it's taking a significant (10% or so) amount of
> time.  Is there a faster (and perhaps less portable?) way to get
> the time information on x86?  My program runs as root, so should
> have any permissions it needs to use some backdoor hack if that
> helps!


#include <asm/msr.h>

/* get this value from the "cpu MHz" line of /proc/cpuinfo */
#define CLOCKSPEED xxxxxxxx

int main()
{
	unsigned int lowbegin, lowend, highbegin, highend;
	unsigned long long diff;
	double elapsed;

	rdtsc(lowbegin,highbegin);

	//do stuff

	rdtsc(lowend,highend);

	if (lowend < lowbegin)
		highend--;

	diff = (((unsigned long long) highend - highbegin) << 32) + (lowend -
lowbegin);

	elapsed = (double) diff / CLOCKSPEED;

	/* elapsed now has time in microseconds, do whatever you wantwith it */	
	
	return 0;
}


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
