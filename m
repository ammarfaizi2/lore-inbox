Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbRGKLEl>; Wed, 11 Jul 2001 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbRGKLEb>; Wed, 11 Jul 2001 07:04:31 -0400
Received: from [195.82.120.238] ([195.82.120.238]:3347 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S267273AbRGKLEZ>; Wed, 11 Jul 2001 07:04:25 -0400
Date: Wed, 11 Jul 2001 12:00:23 +0100
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
Message-ID: <20010711120023.B24339@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
	Jordan <ledzep37@home.com>,
	Jordan Breeding <jordan.breeding@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 10:19:28PM -0500, Jordan wrote:
 > cpuid level     : 2
 > cpuid level     : 3

 > According to Dave J's utility the cpu's appear to be exactly the same
 > just as the Intel boxes said when I bought them.  What might be causing
 > these values to be different.  And if the BIOS is setting things up
 > incorrectly then why does Dave J's utility show the correct values? 
 > Thanks for any help.

This is a mystery to me. Rogier Wolff mentioned the same problem
a month or two back. At the time x86info had a bug that meant that
it was reading the same cpuid info from the same CPU twice in an
SMP box. This is fixed in 1.3 (or at least, should be).

This brings several questions.

1. Why does proc/cpuinfo think they are different.
2. Lowering from 3 -> 2 on a P3 happens when CPU serial number is
   disabled. Is this not happening on the 2nd CPU? If not, why?
3. Why can't we see the discrepancy from userspace?

possibilities include
 a. The CPUID /dev nodes are incorrectly numbered.
    Can you check this, and make sure they have the right
	minors ?
 b. The CPUID driver cpu-scheduling is broken.
    Unlikely, but possible, as afaik x86info is the only
	program where you'd notice this difference.
	hpa?
 c. The CPU serial number disabling is done after the
    /proc/cpuinfo creation. AFAIR this is not the case.
	I'll check further into this after lunch.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs
