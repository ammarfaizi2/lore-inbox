Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUCKAEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCKAEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:04:07 -0500
Received: from palrel12.hp.com ([156.153.255.237]:64421 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262890AbUCKAD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:03:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.44267.253785.644266@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 16:03:55 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: jbarnes@sgi.com (Jesse Barnes), axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
In-Reply-To: <20040310155419.550c4a6a.akpm@osdl.org>
References: <20040310115545.16cb387f.akpm@osdl.org>
	<200403102003.i2AK3qm16576@unix-os.sc.intel.com>
	<20040310202025.GH15087@suse.de>
	<20040310204532.GA10281@sgi.com>
	<20040310204936.GJ15087@suse.de>
	<20040310205237.GK15087@suse.de>
	<20040310210104.GA10406@sgi.com>
	<20040310210249.GM15087@suse.de>
	<20040310213509.GA10888@sgi.com>
	<20040310155419.550c4a6a.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Mar 2004 15:54:19 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> jbarnes@sgi.com (Jesse Barnes) wrote:
  >> 
  >> -------------------------------------
  >> w/Jens' patch: ~47149 I/Os per second

  Andrew> Happier.

  >> [root@revenue sio]# readprofile -m /root/System.map | sort -nr +2
  >> | head -20 181993 default_idle 5687.2812 624772 snidle 1627.0104
  >> 209129 cpu_idle 435.6854 4755 dio_bio_end_io 12.3828 6593
  >> scsi_end_request 12.1195 435 ia64_spinlock_contention 6.7969 2959
  >> sn_dma_flush 4.4033

  Andrew> Do you know where that spinlock contention is coming from?

  Andrew> (We have a little patch for x86 which places the spinning
  Andrew> code inline in the caller of spin_lock() so it appears
  Andrew> nicely in profiles.)

And real men use profiling tools that provide a call-graph, so this
hack isn't necessary... ;-)

Jesse, if you want to try q-tools and need some help in getting the
per-CPU results merged, let me know (it's something that's planned for
a future release, but there is only so many hours in a day so this
hasn't been done yet).

	--david
