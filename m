Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWGPAE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGPAE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWGPAE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:04:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:12462 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964814AbWGPAE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:04:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uaEA1KOS94sR7/Yy50n7Wm3U3nHPf10OE9T0+vVM7GxlluBoq9mM38YI9hp6m8EjGtmZWdDW1ix3SGUjqLiGPlBLym4D0VQofFAmCig7zxDosC72qd+XV7W1QUyfx2oANs6i63K1XuZAbArEaCRoUJ8fisJxtpK/w3sKTinF1cI=
Message-ID: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
Date: Sat, 15 Jul 2006 17:04:57 -0700
From: "Jonathan Baccash" <jbaccash@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: raid io requests not parallel?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel linux-2.6.15-gentoo-r1, and I noticed performance of
the software RAID-1 is not as good as I would have expected on my two
SATA drives, and I was wondering if anyone has an idea what may be
happening. The test I run is 1024 16k direct-IO reads/writes from
random locations within a 1GB file (on a RAID-1 partition), with my
disk caches set to
write-through mode. In the MT (multi-threaded) case, I issue them from
8 threads (so it's 128 requests per thread):

Random read: 10.295 sec
Random write: 19.142 sec
MT Random read: 5.276 sec
MT Random write: 19.839 sec

As expected, the multi-threaded reads are 2x as fast as single-threaded
reads. But I would have expected (assuming the write to both disks can
occur in parallel) that the random writes are about the same speed (10
seconds) as the single-threaded random reads, for both the
single-threaded and multi-threaded write cases. The fact that the
multi-threaded reads were
twice as fast indicates to me that read requests can occur in parallel.

So.... why doesn't the raid issue the writes in parallel? Thanks in
advance for any help.

Jon.
