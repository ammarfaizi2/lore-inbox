Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbTJVBUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJVBUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:20:52 -0400
Received: from diesel.grid4.com ([208.49.116.17]:47744 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S263256AbTJVBUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:20:50 -0400
Date: Tue, 21 Oct 2003 21:21:53 -0400
From: Paul <set@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing. [A 2.6 question about smp irq balancing]
Message-ID: <20031022012153.GA1620@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <3F9396C7.50807@superbug.demon.co.uk> <763050000.1066659824@[10.10.2.4]> <20031021055923.GI13549@squish.home.loc> <7820000.1066746840@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7820000.1066746840@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com>, on Tue Oct 21, 2003 [07:34:01 AM] said:
[paul said]
> > 	Ok, my question is, is this how it is supposed to be?
> > I ask because I am seeing a throughput decrease on 2.6 v 2.4
> > on hdparm -t, bonnie, kernel compile benchmarks, though interactivity
> > seems to be better.
> 
> I doubt that's caused by interrupt load, but try this:
> 

	Hi;

	Thanks;
	This seems to generate a more of a distribution.
(uptime 3 hours) You are correct that I notice no performance
difference.

Paul
set@pobox.com

           CPU0       CPU1       
  0:    5011222    5035676    IO-APIC-edge  timer
  1:       5441          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:       8203          1    IO-APIC-edge  serial
  4:      58980     356739    IO-APIC-edge  serial
  5:          0          0    IO-APIC-edge  eth0
  8:          2          0    IO-APIC-edge  rtc
 12:       4968       3423    IO-APIC-edge  i8042
 14:     119080      62085    IO-APIC-edge  ide0
 15:        142          0    IO-APIC-edge  ide1
 16:        101          1   IO-APIC-level  eth1
 17:        110      10782   IO-APIC-level  eth2
 19:       1776          0   IO-APIC-level  Ensoniq AudioPCI
NMI:   10044606   10041826 
LOC:   10042436   10042460 
ERR:          0
MIS:          0

> diff -urN linux-2.6.0-test4-clean/arch/i386/kernel/io_apic.c
> linux-2.6.0-test4-div10/arch/i386/kernel/io_apic.c
> --- linux-2.6.0-test4-clean/arch/i386/kernel/io_apic.c 2003-09-15
> 06:46:02.000000000 -0700
> +++ linux-2.6.0-test4-div10/arch/i386/kernel/io_apic.c 2003-09-15
> 06:47:17.000000000 -0700
> @@ -393,7 +393,7 @@
>         unsigned long max_cpu_irq = 0, min_cpu_irq = (~0);
>         unsigned long move_this_load = 0;
>         int max_loaded = 0, min_loaded = 0;
> -       unsigned long useful_load_threshold = balanced_irq_interval +
> 10;
> +       unsigned long useful_load_threshold = (balanced_irq_interval +
> 10) / 10;
>         int selected_irq;
>         int tmp_loaded, first_attempt = 1;
>         unsigned long tmp_cpu_irq;
