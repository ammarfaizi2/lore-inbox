Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUCJXwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbUCJXwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:52:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:5554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbUCJXwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:52:35 -0500
Date: Wed, 10 Mar 2004 15:54:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
Message-Id: <20040310155419.550c4a6a.akpm@osdl.org>
In-Reply-To: <20040310213509.GA10888@sgi.com>
References: <20040310115545.16cb387f.akpm@osdl.org>
	<200403102003.i2AK3qm16576@unix-os.sc.intel.com>
	<20040310202025.GH15087@suse.de>
	<20040310204532.GA10281@sgi.com>
	<20040310204936.GJ15087@suse.de>
	<20040310205237.GK15087@suse.de>
	<20040310210104.GA10406@sgi.com>
	<20040310210249.GM15087@suse.de>
	<20040310213509.GA10888@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> -------------------------------------
> w/Jens' patch: ~47149 I/Os per second

Happier.

>   [root@revenue sio]# readprofile -m /root/System.map | sort -nr +2 | head -20
>   181993 default_idle                             5687.2812
>   624772 snidle                                   1627.0104
>   209129 cpu_idle                                 435.6854
>     4755 dio_bio_end_io                            12.3828
>     6593 scsi_end_request                          12.1195
>      435 ia64_spinlock_contention                   6.7969
>     2959 sn_dma_flush                               4.4033

Do you know where that spinlock contention is coming from?

(We have a little patch for x86 which places the spinning code inline in the
caller of spin_lock() so it appears nicely in profiles.)
