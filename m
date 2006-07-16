Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWGPX77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWGPX77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGPX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 19:59:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:63161 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbWGPX76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 19:59:58 -0400
From: Neil Brown <neilb@suse.de>
To: "Jonathan Baccash" <jbaccash@gmail.com>
Date: Mon, 17 Jul 2006 09:59:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17594.53980.497790.409035@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid io requests not parallel?
In-Reply-To: message from Jonathan Baccash on Saturday July 15
References: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 15, jbaccash@gmail.com wrote:
> I'm using kernel linux-2.6.15-gentoo-r1, and I noticed performance of
> the software RAID-1 is not as good as I would have expected on my two
> SATA drives, and I was wondering if anyone has an idea what may be
> happening. The test I run is 1024 16k direct-IO reads/writes from
> random locations within a 1GB file (on a RAID-1 partition), with my
> disk caches set to
> write-through mode. In the MT (multi-threaded) case, I issue them from
> 8 threads (so it's 128 requests per thread):
> 
> Random read: 10.295 sec
> Random write: 19.142 sec

Odd.  I would expect these two numbers to be a lot closer together.

Try changing the IO scheduler on the drives and see if it makes a
difference.
e.g.
  cat /sys/block/XXX/queue/scheduler
  echo cfq > /sys/block/XXX/queue/scheduler
  echo deadline > /sys/block/XXX/queue/scheduler

See what works best.

NeilBrown



> MT Random read: 5.276 sec
> MT Random write: 19.839 sec
> 
> As expected, the multi-threaded reads are 2x as fast as single-threaded
> reads. But I would have expected (assuming the write to both disks can
> occur in parallel) that the random writes are about the same speed (10
> seconds) as the single-threaded random reads, for both the
> single-threaded and multi-threaded write cases. The fact that the
> multi-threaded reads were
> twice as fast indicates to me that read requests can occur in parallel.
> 
> So.... why doesn't the raid issue the writes in parallel? Thanks in
> advance for any help.
> 
> Jon.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
