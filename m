Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131148AbRBEVTs>; Mon, 5 Feb 2001 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRBEVTi>; Mon, 5 Feb 2001 16:19:38 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:16940 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131148AbRBEVTU>; Mon, 5 Feb 2001 16:19:20 -0500
From: lists@frednet.dyndns.org
Date: Mon, 5 Feb 2001 15:19:17 -0600
To: Rusty Russell <rusty@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1@
Message-ID: <20010205151917.A17110@frednet.dyndns.org>
In-Reply-To: <E14PcpU-0004U1-00@halfway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14PcpU-0004U1-00@halfway>; from rusty@linuxcare.com.au on Mon, Feb 05, 2001 at 03:00:40PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Would any special hardware besides a multi-cpu system be necessarey to
test this out?


Matthew Fredrickson

On Mon, Feb 05, 2001 at 03:00:40PM +1100, Rusty Russell wrote:
> Hi all,
> 
> I did the infrastructure, Anton did the bugfinding and PPC support,
> aka. the hard stuff.  Other architectures need to implement
> __cpu_disable, __cpu_die and __cpu_up for them to work.  Volunteers
> appreciated.
> 
> 	This patch allows you to down & up CPUs as follows:
> 	# echo 0 > /proc/sys/cpu/0/online
> 	# echo 1 > /proc/sys/cpu/0/online
> 
> The relatively trivial patch works as follows:
> 
> 1) Implements synchronize_kernel() (thanks Andi Kleen for forwarding
>    Paul McKenney's quiescent-state ideas) which waits for a schedule
>    on all CPUs.
> 2) All CPU numbers are now physical: removes cpu_number_map,
>    cpu_logical_map and smp_num_cpus.
> 3) Adds cpu_online(cpu) and cpu_num_online() macros.
> 4) Adds cpu_down() and cpu_up() calls, which call arch-specific
>    __cpu_disable(cpu), __cpu_die(cpu) and __cpu_up(cpu).
> 5) Fixes schedule() to check allowed_cpus even if rescheduling same
>    task.
> 
> Since it's 60k long, mime attached bzip2.
> 
> Go hack!
> Rusty Russell & Anton Blanchard
> --


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
