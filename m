Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCFQzc>; Wed, 6 Mar 2002 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293675AbSCFQzW>; Wed, 6 Mar 2002 11:55:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293683AbSCFQzC>; Wed, 6 Mar 2002 11:55:02 -0500
Date: Wed, 6 Mar 2002 11:54:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <3C8640C8.367A30BB@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020306115330.12216A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-311791659-1015433686=:12216"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-311791659-1015433686=:12216
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 6 Mar 2002, Chris Friesen wrote:

> Ben Greear wrote:
> > 
> > I have a program that I very often need to calculate the current
> > time, with milisecond accuracy.  I've been using gettimeofday(),
> > but gprof shows it's taking a significant (10% or so) amount of
> > time.  Is there a faster (and perhaps less portable?) way to get
> > the time information on x86?  My program runs as root, so should
> > have any permissions it needs to use some backdoor hack if that
> > helps!
> 
> 
> #include <asm/msr.h>
> 
> /* get this value from the "cpu MHz" line of /proc/cpuinfo */
> #define CLOCKSPEED xxxxxxxx
> 
> int main()
> {
> 	unsigned int lowbegin, lowend, highbegin, highend;
> 	unsigned long long diff;
> 	double elapsed;
> 
> 	rdtsc(lowbegin,highbegin);
> 
> 	//do stuff
> 
> 	rdtsc(lowend,highend);
> 
> 	if (lowend < lowbegin)
> 		highend--;
> 
> 	diff = (((unsigned long long) highend - highbegin) << 32) + (lowend -
> lowbegin);
> 
> 	elapsed = (double) diff / CLOCKSPEED;
> 
> 	/* elapsed now has time in microseconds, do whatever you wantwith it */	
> 	
> 	return 0;
> }
> 
> 
> -- 
> Chris Friesen                    | MailStop: 043/33/F10  
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
> -

Also, a bit more accurate is enclosed.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

--1678434306-311791659-1015433686=:12216
Content-Type: APPLICATION/octet-stream; name="timer.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020306115446.12216B@chaos.analogic.com>
Content-Description: 

H4sIAH5JhjwAA+xae3BbVXq/edtKSExClkBCuCUJa2dlWfdKlmSbQBRbcQSy
ZCQ5D5JwkaUrS8m1rtC9chIgy4KzEI+HaaaddmG6w1K225nu7FBKd7ZsmWmz
kGXTlu2ELtNmhvKctHUKu6XdXUiHFPf7vnMfxy8Cf4SdTnPHV+d3vu8753yv
85JllofVWptwWR8x6A+3t4uCiI9/WmlVxHAwKAWDwXYZsOSXQkFBbL+8arGn
bpi5migKNV03P03uUvz/o49J8a8VTCPvy1ymMSS/PxQMzhl/SZKCdvylcCiA
lHY5LIj+y6TPlOf/efw3eDY0ZktlQ4S/Yk1VRUMvmodyNVU8VCubploRB4+I
6XK+lKsVxG0+8Xa9VDH0ik9M6tAyr1eP1MpDJROb57UcJFPBJ8apmtMMXazo
pjhUz9VyFVNVC6KpiwVdzFWOmKVyZQg6qBtqsa75PKCGx+Mr5MycR8sZptbZ
6NP0ylCjn6olt+oz1cOmx5fTykOVxkijxzek6YNaI6QxsI5UVRHh1mK9kjfL
esWDHYtiWjXrtYpollSxu38AFNXzB8VCuVhUa2olr4qDqnlIBVONej6vGkZ5
RBXzOU0zUC/orrOxWjdKWuMmdfCwp5HmiqdxWB/RGklXr4iMxsYNYq9qikgS
Nf2QiAof0msFTrSEovmpoiVw33TZTWrusJfYGspmcqhQvQbKztr1JrVgiZdm
iE/r3qgPMjtQkxxp0m1JtlIPIDJIInkSKRxmPQ5DPpTNkjio12r6IU9jVa86
/lAhHmql4PH8pnP5yvP5H7b+m6phqjVf/vKMcan1PxCU3P1fCuP6Hw76r6z/
X8QDK2S5ktfqBVW8xTALZd1XupUj1StloCKtDEvEcK5caR7Ry4WWLg8swyqs
qfWKASsxLO24xrAPSKlmEHBbtHju92CgZ5HNV+uKUYWtwSuaphdX3fJgFwkX
dFiqVBE2iDwjsIFZ5/a5sW2zGK+UzTI0u08VN7eRIHUibhF5URDsRnItZ6qi
vTu04iLPdoQjeU017A6qNVC92HxTFmYFbFMkkUElxWYdt4ucKWLSmKJeBFl9
qJYbbtlXuallpp4cwdBUtdosWTTHbltPWH45420NcGRbbJOm1cUd98FAXrd5
S9esGuNOhzMbN1zcx1Vx3007VE3TxV16TSv81r6bkENSam24XMlpvk8xoFo3
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
QX3mjKS+1qC+vvcf4uPc+PITgYl6hSEMtqR8i827t5TwthJ/DeLjmcJNGf4N
4wFcv1TC8YwlQhbvsPDXjA+xHO8n4R/B9S1FxrOX31TyQyxhTsqvrvTnk0eJ
P39SZEwP73dvKfExvz8/0vPbVPL7m5HgzND/f6T8W9Uenyn5f7ki3Ho/Cb9p
Jv4hmvslkO8o8m1Tj/8GyI1HAjv9ovGmqWOvv2/q2OsfmDr2umzq2OttU8de
10wdS/0jU8deR6aOvb6fugfNTR17fW3q2OsPTR1L/ZFJ9fFtk/z52EzGbw78
/5WpY7N/YxL2zef+/97Usdp/TKX/qaljtf9i6ljtv5o6VvvvSv63IP8vUv59
fU2X2es0XNo9fzC21e3Z+OcY4/lysbw6OQGbS0RYxwFuEOL7gDjmhwiXEKOI
pzpmMX4hcHQes6VgPLp6D7RhI97t4Z7jTohbkrGBOcbHV9PptTE7+jG+g/UM
tpLkSgYLJ/ZkNh9P4uUs5kDuupK3mt9YyY/ZhO2AmQSqQMUgSX6FjX35j/2f
Gsk54eXZVODQE1w7ocr/PS5dANyPJ/JNNvl2dnEyk/j05/DvKkYdv+NloMPC
mpDz/MlMoOQFuH012B5h7mQWqynFKwulI/ozyiijjDLKKKOMMsooo4wyyiij
jDLKKKOMMsooo4wyyiijjDLKKKOMMvoq+hcUnFrlAHgAAA==
--1678434306-311791659-1015433686=:12216--
