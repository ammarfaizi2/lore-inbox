Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTGZDDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 23:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272406AbTGZDDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 23:03:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:14789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272405AbTGZDDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 23:03:15 -0400
Date: Fri, 25 Jul 2003 20:19:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: albert@users.sourceforge.net, linux-yoann@ifrance.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com, vortex@scyld.com,
       jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030725201914.644b020c.akpm@osdl.org>
In-Reply-To: <1059097601.1220.75.camel@cube>
References: <1054431962.22103.744.camel@cube>
	<3EDCF47A.1060605@ifrance.com>
	<1054681254.22103.3750.camel@cube>
	<3EDD8850.9060808@ifrance.com>
	<1058921044.943.12.camel@cube>
	<20030724103047.31e91a96.akpm@osdl.org>
	<1059097601.1220.75.camel@cube>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> I hope you don't consider a 100 Mb/s PCI device to be
> a nasty old NIC. It's not an NE2000 you know! I have this:

Sorry, I got my boomerangs and vortices mixed up. Vortex is the ancient one.

> I added code to the top and bottom of do_IRQ, as well as to
> the top and bottom of boomerang_interrupt. The lockmeter was
> compiled into the kernel but never enabled. I record the
> minimum and maximum time in microseconds.
> 
> -------------------------------
> IRQ    num use      min     max
> --- ------ -------- --- -------   
>   0 746770 timer     40  103595
>   1    936 i8042     13  389773
>   2      0 cascade    -       -
>   3      - -          -       -
>   4      9 serial    28      56
>   5      0 uhci-hcd   -       -
>   6      - -        711     711
>   7      - -         25      25
>   8      - -          -       -
>   9      - -          -       -
>  10      - -          -       -
>  11   2417 eth0      87 1535331
>  12     60 i8042     18  102895
>  13      - -          -       -
>  14  13844 ide0       8   51944
>  15      2 ide1       7      11 

But did your instrumentation account for nested interrupts?  What happens
if a slow i8042 interrupt happens in the middle of a 3c59x interrupt?

Still, that probably doesn't account for the stalls.

I don't know what does account for it, frankly.  You could try dropping the
2.4 driver into the 2.5 tree just to verify that it is not a driver
problem.  The driver has hardly changed at all.

