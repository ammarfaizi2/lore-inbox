Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbTGWPVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTGWPVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:21:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47286 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270383AbTGWPVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:21:08 -0400
Date: Wed, 23 Jul 2003 17:30:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030723153005.GC2530@suse.de>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723132037.GA30550@dsl2.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723132037.GA30550@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23 2003, Grant Grundler wrote:
> On Tue, Jul 08, 2003 at 03:23:14PM -0700, David S. Miller wrote:
> > dbench type stuff,
> 
> realizing dbench is blissfully ignorant of the system (2GB RAM),
> for grins I ran "dbench 500" to see what would happen. The throughput
> rate dbench reported continued to decline to ~20MB/s. This is about what
> I would expect for one disk a 40MB/s SCSI bus.
> 
> Then dbench started spewing errors:
> ..
> (7) ERROR: handle 13781 was not found
> (6) open clients/client428 failed for handle 13781 (No such file or
> directory)
> (7) ERROR: handle 13781 was not found
> (6) open clients/client423 failed for handle 13781 (No such file or directory)
> (7) ERROR: handle 13781 was not found
> (6) open clients/client48 failed for handle 13781 (No such file or directory)
> (7) ERROR: handle 13781 was not found
> (6) open clients/client55 failed for handle 13781 (No such file or directory)
> (7) ERROR: handle 13781 was not found
> (6) open clients/client419 failed for handle 13781 (No such file or directory)
> (7) ERROR: handle 13781 was not found
> (6) open clients/client415 failed for handle 13781 (No such file or directory)
> ..
> write failed on handle 13783
> write failed on handle 13707
> write failed on handle 13808
> write failed on handle 13117
> write failed on handle 13850
> write failed on handle 14000
> write failed on handle 13767
> write failed on handle 13787
> ..
> 
> NFC what that's all about. sorry - I have to punt on digging deeper.

You are running out of disk space, most likely :-)

> I really need more guidance on
> 	(a) how much memory I should be testing with

With 2G of RAM, you need lots of clients. Would be much saner to just
boot with 256M, or something like that.

> 	(b) how many spindles would be useful (I've got ~15 on each box)
> 	(c) how to tell dbench to use the FS mounted on the target disks.
> 
> I've attached the iommu stats in case anyone finds that useful.

To be honest, I don't think dbench is terrible useful for this. It often
suffers from the butterfly effect, so with the small improvements
virtual merging should so will most likely be lost in the noise.

-- 
Jens Axboe

