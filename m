Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVJGIN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVJGIN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJGIN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:13:29 -0400
Received: from fmr16.intel.com ([192.55.52.70]:51139 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932101AbVJGIN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:13:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] add sysfs to dynamically control blk request tag maintenance
Date: Fri, 7 Oct 2005 01:13:21 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5086AEC33@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] add sysfs to dynamically control blk request tag maintenance
Thread-Index: AcXLFhYoKxsCkWQuQ9CUfyrHTCj8PgAADN5w
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Oct 2005 08:13:22.0446 (UTC) FILETIME=[FBD18AE0:01C5CB16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Friday, October 07, 2005 1:08 AM
> > It's probably a very small number that I'm chasing with avoiding blk
> > layer tagging.  Nevertheless, any number no matter how small, is a
gold
> > mine to me :-)
> > 
> > Latest execution profile taken with 2.6.14-rc2 kernel with "industry
> > standard transaction processing database workload".  First column is
> > clock ticks (a direct measure of time), 2nd column is instruction
> > retired,
> > and 3rd column is number of L3 misses occurred inside the function.
> > 
> > Symbol			Clockticks	Inst. Retired	L3
Misses
> > scsi_request_fn		8.12%	9.27%	11.18%
> > Schedule			6.52%	4.93%	7.26%
> > scsi_end_request		4.44%	3.59%	6.76%
> > __blockdev_direct_IO	4.28%	4.38%	3.98%
> > __make_request		3.59%	4.16%	3.47%
> > __wake_up			2.46%	1.56%	3.33%
> > dio_bio_end_io		2.14%	1.67%	3.18%
> > aio_complete		2.05%	1.27%	3.56%
> > kmem_cache_free		1.95%	1.70%	0.71%
> > kmem_cache_alloc		1.45%	1.84%	0.45%
> > put_page			1.42%	0.60%	1.27%
> > follow_hugetlb_page	1.41%	0.75%	1.27%
> > __generic_file_aio_read	1.37%	0.36%	1.68%
> 
> The above looks pretty much as expected. What change in profile did
you
> see when eliminating the blk_queue_end_tag() call?

I haven't make any measurement yet.  The original patch was an RFC, and
I want to hear opinions from the experts first.  I will do a measurement
with the change in qla2x00 driver and I will let you know how much
difference does it make.  Most likely, clock ticks in scsi_request_fn
and
scsi_end_request should be reduced.  It will be interesting to see L3
misses stats as well.

- Ken
