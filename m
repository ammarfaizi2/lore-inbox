Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCBUfm>; Sun, 2 Mar 2003 15:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCBUfm>; Sun, 2 Mar 2003 15:35:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43981 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262789AbTCBUfl>; Sun, 2 Mar 2003 15:35:41 -0500
Date: Sun, 02 Mar 2003 12:46:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <50380000.1046637959@[10.10.2.4]>
In-Reply-To: <20030302202451.GJ1195@holomorphy.com>
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Mar 02, 2003 at 10:24:37AM -0800, Martin J. Bligh wrote:
>> Odd. I get nothing like that difference.
>> Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
>>                               Elapsed        User      System         CPU
>>               2.5.63-mjb2       44.43      557.16       95.31     1467.83
>>       2.5.63-mjb2-pernode       44.21      556.92       95.16     1474.33
>> Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
>>                               Elapsed        User      System         CPU
>>               2.5.63-mjb2       45.39      560.26      117.25     1492.33
>>       2.5.63-mjb2-pernode       44.78      560.24      112.20     1501.17
>> No difference for make -j32, definite improvement in the systime for -j256.
> 
> Maybe your machine's running slow?
> AFAIK the machines we're using are identical, and mine sees:

No, I just started using a config file for kernbench that has every option
under the sun turned on ;-) Makes a longer test, and stabilises results.
ftp://ftp.kernel.org/pub/linux/kernel/people/people/mbligh/config/kernbench2.config
(2.4.17). It's the difference between before and after runs that's going to
be interesting anyway.

> make -j bzImage > /dev/null  317.70s user 148.43s system 1295% cpu 35.984 total
> (yes, this is 5 off of 41s, apparently 1s measurement variations are typical)

make -j is going to spawn as many tasks as possible, creating a massive
forkbomb ... that might be behind the differences - your patch might make
more of a difference for huge amounts of context switching / cache thrash
(not necessarily a bad thing, I just want to find the cause).
 
> make -j36 bzImage > /dev/null  302.33s user 115.02s system 1284% cpu 32.492 total
> make -j38 bzImage > /dev/null  302.52s user 117.06s system 1300% cpu 32.258 total
> make -j40 bzImage > /dev/null  303.53s user 117.42s system 1305% cpu 32.251 total
> make -j44 bzImage > /dev/null  304.02s user 122.14s system 1299% cpu 32.792 total

How does that compare with and without your patch though?

Would be useful if you can grab a before and after profile, and see exactly
what it is that's getting thrashed that you're fixing (may just be everything).

M.

