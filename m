Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDDHvR (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDDHvR (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:51:17 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:3224 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S262932AbTDDHsv (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 02:48:51 -0500
Date: Fri, 4 Apr 2003 10:00:18 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm2
In-Reply-To: <20030403132243.7bc9a22d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0304040955060.20588@dns.toxicfilms.tv>
References: <20030401000127.5acba4bc.akpm@digeo.com>
 <Pine.LNX.4.51.0304031947321.16306@dns.toxicfilms.tv> <20030403132243.7bc9a22d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > remember my post about the machine locking up for a few seconds?
>
> Could you try 2.5.66-mm3?  It has a CPU scheduler fix which might well help here.
It's still there.
Using the following script to get vmstat output...
#!/bin/sh
rm vmlog
while (true);
do
        echo "-----" >> vmlog
        date >> vmlog
        for i in `seq 1 5`; do
                vmstat >> vmlog
                sleep 1;
        done;
done

I managed to get the following. The lockup occured between 9:53:00, and
9:53:20.

pi± kwi  4 09:52:58 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  1  65724   4676   7256  48936    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  65724   4636   8184  49048    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  65724   4636   8184  49048    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  65716   5452   7456  49028    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  65716   5452   7456  49028    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 7 10  65716   4148   7476  49040    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6 10  65716   4148   7476  49040    8    6    42    44  224   472 98  1  0  0
-----
pi± kwi  4 09:53:20 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 5  6  65736   4532   7344  48804    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 4  6  65736   4532   7348  48804    8    6    42    44  224   472 98  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
-----
pi± kwi  4 09:53:21 CEST 2003

Running apps: [debian] xmms + opera + setiathome + x-terminal-emulator

It just stopped responding suddenly for 20 seconds and went on.
I think i need some other method of measuring what is going on.

Notice, that there are only 7 results between these 20 seconds, and there
should be 20. Earlier in the logs i also get these irregularities, the
script can not manage to get it on time, or the script is getting skewed
by some other factors i am unaware of.


Regards,
Maciej
