Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310645AbSCHB5g>; Thu, 7 Mar 2002 20:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310640AbSCHB51>; Thu, 7 Mar 2002 20:57:27 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:30874 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310649AbSCHB5P>; Thu, 7 Mar 2002 20:57:15 -0500
Date: Fri, 8 Mar 2002 01:57:01 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
Message-ID: <20020308015701.C14779@kushida.apsleyroad.org>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no> <a68bo4$b18$1@cesium.transmeta.com> <20020308013222.B14779@kushida.apsleyroad.org> <3C88157E.5010106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C88157E.5010106@zytor.com>; from hpa@zytor.com on Thu, Mar 07, 2002 at 05:35:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> I would like to see the error bars on your measurement.

I just ran it on my laptop 20 times in a row and it printed exactly the
same values every time:

	Kernel reports clock frequency:  366.601 MHz
	Measured clock frequency:        366.584 MHz

Well we need more precision than that.  So here goes:

	Kernel reports clock frequency:  366.601000 MHz

	Measured clock frequency:        366.584116 MHz
	Measured clock frequency:        366.584071 MHz
	Measured clock frequency:        366.584108 MHz
	Measured clock frequency:        366.584116 MHz
	Measured clock frequency:        366.584090 MHz
	Measured clock frequency:        366.583968 MHz
	Measured clock frequency:        366.584069 MHz
	Measured clock frequency:        366.584106 MHz
	Measured clock frequency:        366.584172 MHz
	Measured clock frequency:        366.584093 MHz
	Measured clock frequency:        366.584077 MHz
	Measured clock frequency:        366.583939 MHz
	Measured clock frequency:        366.584083 MHz
	Measured clock frequency:        366.584118 MHz
	Measured clock frequency:        366.584062 MHz
	Measured clock frequency:        366.584085 MHz
	Measured clock frequency:        366.584066 MHz
	Measured clock frequency:        366.610417 MHz <- anomaly :-)
	Measured clock frequency:        366.584109 MHz
	Measured clock frequency:        366.584062 MHz
	Measured clock frequency:        366.582293 MHz
	Measured clock frequency:        366.584103 MHz
	Measured clock frequency:        366.584093 MHz
	Measured clock frequency:        366.584107 MHz
	Measured clock frequency:        366.584059 MHz
	Measured clock frequency:        366.583985 MHz
	Measured clock frequency:        366.584133 MHz
	Measured clock frequency:        366.584092 MHz
	Measured clock frequency:        366.584087 MHz
	Measured clock frequency:        366.555754 MHz <- another deviant!
	Measured clock frequency:        366.584044 MHz
	Measured clock frequency:        366.584109 MHz
	Measured clock frequency:        366.584084 MHz
	Measured clock frequency:        366.583608 MHz
	Measured clock frequency:        366.584112 MHz
	Measured clock frequency:        366.584134 MHz
	Measured clock frequency:        366.584049 MHz
	Measured clock frequency:        366.584090 MHz
	Measured clock frequency:        366.584155 MHz
	Measured clock frequency:        366.584006 MHz
	Measured clock frequency:        366.584182 MHz
	Measured clock frequency:        366.584009 MHz

It takes the median of 1000 samples of the TSC time taken to do a
rdtsc/gettimeofday/rdtsc measurement, then uses that as the threshold
for deciding which of the subsequent 1000000 measurements are accepted.
Then linear regression through the accepted points.

I see a couple of results there which suggests a probable fault in the
filtering algorithm.  Perhaps it should simply use the smallest TSC time
taken as the threshold.

Sorry, I'd need permission to post the code.

enjoy,
-- Jamie
