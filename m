Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269286AbTCBUOr>; Sun, 2 Mar 2003 15:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269287AbTCBUOr>; Sun, 2 Mar 2003 15:14:47 -0500
Received: from holomorphy.com ([66.224.33.161]:57742 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S269286AbTCBUOq>;
	Sun, 2 Mar 2003 15:14:46 -0500
Date: Sun, 2 Mar 2003 12:24:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030302202451.GJ1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <47970000.1046629477@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47970000.1046629477@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> Tested, boots, and runs on NUMA-Q. Trims 6s of 41s off kernel compiles.

On Sun, Mar 02, 2003 at 10:24:37AM -0800, Martin J. Bligh wrote:
> Odd. I get nothing like that difference.
> Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
>                               Elapsed        User      System         CPU
>               2.5.63-mjb2       44.43      557.16       95.31     1467.83
>       2.5.63-mjb2-pernode       44.21      556.92       95.16     1474.33
> Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed        User      System         CPU
>               2.5.63-mjb2       45.39      560.26      117.25     1492.33
>       2.5.63-mjb2-pernode       44.78      560.24      112.20     1501.17
> No difference for make -j32, definite improvement in the systime for -j256.

Maybe your machine's running slow?
AFAIK the machines we're using are identical, and mine sees:

make -j bzImage > /dev/null  317.70s user 148.43s system 1295% cpu 35.984 total
(yes, this is 5 off of 41s, apparently 1s measurement variations are typical)

make -j36 bzImage > /dev/null  302.33s user 115.02s system 1284% cpu 32.492 total
make -j38 bzImage > /dev/null  302.52s user 117.06s system 1300% cpu 32.258 total
make -j40 bzImage > /dev/null  303.53s user 117.42s system 1305% cpu 32.251 total
make -j44 bzImage > /dev/null  304.02s user 122.14s system 1299% cpu 32.792 total

Check MTRR's etc.?


-- wli
