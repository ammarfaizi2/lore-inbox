Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbRJFUm7>; Sat, 6 Oct 2001 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275718AbRJFUms>; Sat, 6 Oct 2001 16:42:48 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:12955 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S275716AbRJFUmh>; Sat, 6 Oct 2001 16:42:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Olaf Zaplinski <o.zaplinski@mediascape.de>
Subject: Re: Linux 2.4.11-pre4
Date: Sat, 6 Oct 2001 22:42:59 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1565164462.1002292544@mbligh.des.sequent.com>
In-Reply-To: <1565164462.1002292544@mbligh.des.sequent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011006204242Z275716-761+16343@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Oktober 2001 23:35 schrieb Martin J. Bligh:
> > 1. OK, it fixes the UP UP_IOAPIC compilation problem.
> > System (with preempt-patch) up and runnig.
>
> Good.
>
> > 2. Woohu. I have 8 CPUs, now...;-)
> > --- /proc is somewhat broken
>
> Bugger. Didn't realise that cpu_online_map didn't get initialised
> to anything sensible under UP. Should be just cosmetic (it's only
> the output of /proc/cpuinfo, not the sceduler or anything), but
> try this (I haven't tested it yet - if it doesn't work, just change the
> 8 to 1 for a second whilst I fix it properly).

The first version works nice.

Have a nice weekend.

-Dieter


> ===========================
>
> --- setup.c.old	Fri Oct  5 14:20:29 2001
> +++ setup.c	Fri Oct  5 14:28:51 2001
> @@ -2420,7 +2420,7 @@
>  	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
>  	 * page buffer and corrupts memory - this needs fixing properly
>  	 */
> -	for (n = 0; n < 8; n++, c++) {
> +	for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
>  	/* for (n = 0; n < NR_CPUS; n++, c++) { */
>  		int fpu_exception;
>  #ifdef CONFIG_SMP
>
> ===========================
>
> The reason for this hackery is that get_cpuinfo writes to a page
> without proper bounds on itself. If you have more than about 8
> cpus, it tramples merrily all over the next page, corrupting page
> tables, etc, etc.
>
> The real fix for this overflow was published here a few weeks ago
> by James Cleverdon (whom I work with). It's in Alan's tree, but not
> Linus' as yet.
>
> M.
