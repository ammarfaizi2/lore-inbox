Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbTCPLBv>; Sun, 16 Mar 2003 06:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCPLBv>; Sun, 16 Mar 2003 06:01:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:45316 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262650AbTCPLBv>;
	Sun, 16 Mar 2003 06:01:51 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1 
In-reply-to: Your message of "Sun, 16 Mar 2003 02:10:55 -0800."
             <20030316101055.GG20188@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Mar 2003 22:12:24 +1100
Message-ID: <17275.1047813144@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 02:10:55 -0800, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Sun, Mar 16, 2003 at 08:19:31PM +1100, Keith Owens wrote:
>> Good, it lets us optimize for 1/32/64/lots of cpus.  NR_CPUS > 8 *
>> sizeof(unsigned long) is the interesting case, it needs arrays.
>
>Hmm. It shouldn't make a difference with respect to optimizing them.
>My API passes transparently by reference:
>#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)

Some of the 64 bit archs implement test_bit() as taking int * instead
of long *.  That generates unoptimized code for the case of NR_CPUS <
64.

#if NR_CPUS < 64
#define cpu_isset(cpu, map)		(map.mask & (1UL << (cpu)))
...

generates better code on those architectures.  Yet another special case :(

