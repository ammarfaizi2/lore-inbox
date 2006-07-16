Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWGPDWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWGPDWH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 23:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWGPDWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 23:22:07 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:7823 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964871AbWGPDWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 23:22:06 -0400
Date: Sat, 15 Jul 2006 23:17:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: raid io requests not parallel?
To: "Jonathan Baccash" <jbaccash@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607152320_MC3-1-C51B-11C9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>

On Sat, 15 Jul 2006 17:04:57 -0700, Jonathan Baccash wrote:

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

But it does issue writes in parallel.  The problem is in the way RAID1
works.  When you do a read from the RAID1, it issues one read request
to one of the underlying disks.  When you do a write, it issues one write
request to _each_ of the underlying disks.  So with two disks in the
mirror set, every write issued by your program causes two disk writes.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
