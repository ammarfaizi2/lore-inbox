Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSEKEPr>; Sat, 11 May 2002 00:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEKEPq>; Sat, 11 May 2002 00:15:46 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:44481 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314417AbSEKEPq>; Sat, 11 May 2002 00:15:46 -0400
Message-ID: <3CDC9BDC.F96F7C36@attbi.com>
Date: Sat, 11 May 2002 00:19:40 -0400
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 64-bit jiffies, a better solution
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First what problem are you trying to solve?
Why not have both variables and if they happen
to endup in the same cache line you probably 
need years worth of jiffies to notice how
long one more add takes.  E.g.

	jiffies_64++;
	jiffies++;

To round out the list of options, how about a few lines of 
inline asm?  Maybe something like:

   extern unsigned long long jiffie_64;
   extern unsigned int jiffie;
   __asm__ (" \
        .data
        .align  8
        .global jiffie
        .global jiffie_64
        .type   jiffie,@object
        .size   jiffie,4
        .type   jiffie_64,@object
        .size   jiffie_64,8
   jiffie_64:
   jiffie:
        .long   0, 0
   ");

Adding the obvious ifdef of course.  Aside for broken
binutils this might be portable code :-)

Jim Houston - Concurrent Computer
Corp.
