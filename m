Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTKKFqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTKKFqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:46:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:34784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264268AbTKKFqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:46:51 -0500
Date: Mon, 10 Nov 2003 21:50:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
Message-Id: <20031110215049.58a1c2d8.akpm@osdl.org>
In-Reply-To: <1068528589.22809.153.camel@soul.jpj.net>
References: <1068519213.22809.81.camel@soul.jpj.net>
	<20031110195433.4331b75e.akpm@osdl.org>
	<1068523328.25805.97.camel@soul.jpj.net>
	<20031110202819.7e7433a8.akpm@osdl.org>
	<1068524657.25804.110.camel@soul.jpj.net>
	<20031110205443.6422259f.akpm@osdl.org>
	<1068528589.22809.153.camel@soul.jpj.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Venezia <pvenezia@jpj.net> wrote:
>
> On Mon, 2003-11-10 at 23:54, Andrew Morton wrote:
> 
>  > OK, the IO rates are obviously very poor, and the context switch rate is
>  > suspicious as well.  Certainly, testing with the single disk would help.
> 
>  I pulled the secondary, reconfigured to single drives and rebooted. All
>  is now well, performance is right where it should be.
> 
> 
>   0  0      0 1475924   7052  42384    0    0     0     0 1015     6
>   0  0      0 1475284   7076  42360    0    0     0   156 1041   311
>   0  0      0 1475284   7076  42360    0    0     0     0 1016    12
>   0  0      0 1475284   7076  42360    0    0     0     0 1026    30
>   2  0      0 1252628   7300 258852    0    0     8 37240 1157   119
>   0  3      0 1027284   7524 478064    0    0     8 66016 1441   317
>   1  3      0 818132   7728 682948    0    0     4 70752 1439   202 
>   1  3      0 593236   7944 901760    0    0     4 64576 1452    92 
>   0  4      0 531412   8008 961876    0    0     4 63680 1434    97 

OK, so either we broke the driver or there is some tuning sensitivity.

Could you please do:

	mkdir /sys
	mount none /sys -t sysfs
	cd /sys/block/sdXX/queue
	echo 512 > nr_requests

and retry the RAID setup?

Beyond that, dunno.  We'll need to hunt down the people who worked on that
driver.

