Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVBUHvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVBUHvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVBUHvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:51:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261865AbVBUHvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:51:44 -0500
Date: Mon, 21 Feb 2005 08:51:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Merging fails reading /dev/uba1
Message-ID: <20050221075131.GT4056@suse.de>
References: <20050220200059.53db7b1e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050220200059.53db7b1e@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20 2005, Pete Zaitcev wrote:
> Hi, Jens:
> 
> I think this question belongs to your domain, but please let me know
> if I'm mistaken, so I can pursue this elsewhere.
> 
> I encountered a strange performance anomaly. I do the following:
> 
> <----- Plug USB key
> [root@lembas ~]# time dd if=/dev/uba of=/dev/null bs=10k count=10240
> 10240+0 records in
> 10240+0 records out
> 
> real    0m22.731s
> user    0m0.004s
> sys     0m0.345s
> [root@lembas ~]#
> 
> <----- Remove and replug the USB key
> [root@lembas ~]# time dd if=/dev/uba1 of=/dev/null bs=10k count=10240
> 10240+0 records in
> 10240+0 records out
> 
> real    1m42.622s
> user    0m0.005s
> sys     0m1.518s
> [root@lembas ~]#
> 
> So, reading from a partition of the same device is 5 times slower than
> reading from the device itself. The question is, why?
> 
> To the best of my knowledge, this does not occur with SCSI (usb-storage
> and sd or sr). This hints strongly that the ub is not doing something
> right, but what that can be?
> 
> The ub takes the request processing machinery from Carmel exactly. I am
> wondering if Carmel (sx8) exhibits any similar performance anomalies
> (cc-ing to Jeff)

I can't explain why the replugging slows it down, maybe you were lucky
to get contigious pages in the first case? As far as I can see, ub
effectively disables merging by setting max hw/phys segment limit of 1.

-- 
Jens Axboe

