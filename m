Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbTB1Vli>; Fri, 28 Feb 2003 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268246AbTB1Vkb>; Fri, 28 Feb 2003 16:40:31 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:502 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S268239AbTB1VjX>;
	Fri, 28 Feb 2003 16:39:23 -0500
Date: Fri, 28 Feb 2003 22:49:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, cliffw@osdl.org,
       Andrew Morton <akpm@zip.com.au>, Steven Pratt <slpratt@austin.ibm.com>,
       John Levon <levon@movementarian.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <20030228214937.GA15540@win.tue.nl>
References: <8550000.1046419962@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8550000.1046419962@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 12:12:42AM -0800, Martin J. Bligh wrote:

> +Readprofile
> +-----------
> +get readprofile binary fixed for 2.5 / akpm's 2.5 patch from 
> +ftp://ftp.kernel.org/pub/linux/people/mbligh/tools/readprofile/
> +add "profile=2" to the kernel command line.
> +
> +clear		echo 2 > /proc/profile

As far as I can see, the 2 is meaningless here. This should just be

	echo > /proc/profile

(On SMP when writing sizeof(int) bytes, the value written
is significant. But 1 or 2 is not sizeof(int).)

Andries

-----
Fragment of some notes:

<sect1>Profiling the kernel<p>
There are several facilities to see where the kernel spends
its resources. A simple one is the profiling function, that
stores the current EIP (instruction pointer) at each clock tick.
<p>
Boot the kernel with command line option <tt>profile=2</tt>
(or some other number instead of 2). This will cause
a file <tt>/proc/profile</tt> to be created.
The number given after <tt>profile=</tt> is the number of positions
EIP is shifted right when profiling. So a large number gives a
coarse profile.
The counters are reset by writing to <tt>/proc/profile</tt>.
The utility <tt>readprofile</tt> will output statistics for you.
It does not sort - you have to invoke <tt>sort</tt> explicitly.
But given a memory map it will translate addresses to kernel symbols.
<p>
See <tt>kernel/profile.c</tt> and <tt>fs/proc/proc_misc.c</tt>
and <tt>readprofile(1)</tt>.
<p>
For example:
<verb>
# echo > /proc/profile
...
# readprofile -m System.map-2.5.59 | sort -nr | head -2
510502 total                                      0.1534
508548 default_idle                           10594.7500
</verb>
