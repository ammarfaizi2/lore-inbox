Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTB1IS2>; Fri, 28 Feb 2003 03:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTB1IS1>; Fri, 28 Feb 2003 03:18:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:11669 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267602AbTB1IS0>;
	Fri, 28 Feb 2003 03:18:26 -0500
Date: Fri, 28 Feb 2003 00:29:35 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-Id: <20030228002935.256ffa98.akpm@digeo.com>
In-Reply-To: <8550000.1046419962@[10.10.2.4]>
References: <8550000.1046419962@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 08:28:39.0514 (UTC) FILETIME=[652D03A0:01C2DF03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> ...
> +get readprofile binary fixed for 2.5 / akpm's 2.5 patch from 
> +ftp://ftp.kernel.org/pub/linux/       people/mbligh/tools/readprofile/

                                  kernel/

> +add "profile=2" to the kernel command line.
> +
> +clear		echo 2 > /proc/profile
> +		<test>
> +dump output	readprofile -m /boot/System.map > catured_profile

util-linux-2.11z (at least) has the fixed readprofile.

Of course, installing standard util-linux turns your boot process
into a complete mess because vendors have added incompatible features
to their versions.  But it seems to struggle through.

> +Oprofile
> +--------
> +get source (I use 0.5) from http://oprofile.sourceforge.net/
> +add "poll=idle" to the kernel command line 
> +Configure with CONFIG_PROFILING=y and CONFIG_OPROFILE=y & reboot on new kernel
> +./configure --with-kernel-support
> +make install
> +
> +One time setup (pick appropriate one for your CPU):
> +P3		opcontrol --setup --vmlinux=/boot/vmlinux \
> +		--ctr0-event=CPU_CLK_UNHALTED --ctr0-count=100000
> +Athalon		opcontrol --setup --vmlinux=/boot/vmlinux \

   Athlon

> +		--ctr0-event=RETIRED_INSNS --ctr0-count=100000
> +P4		opcontrol --setup --vmlinux=/boot/vmlinux \
> +		--ctr0-event=GLOBAL_POWER_EVENTS \
> +		--ctr0-unit-mask=1 --ctr0-count=100000
> +
> +start daemon	opcontrol --start-daemon
> +clear		opcontrol --reset
> +start		opcontrol --start
> +		<test>
> +stop		opcontrol --stop
> +dump output	oprofpp -dl -i /boot/vmlinux  >  output_file
> +

OK.  Might be worth adding a pointer to this in REPORTING-BUGS, but
nobody reads that anyway.

