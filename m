Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTHLPjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271071AbTHLPju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:39:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1942 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270724AbTHLPjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:39:49 -0400
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jan Niehusmann <jan@gondor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030811003343.A16918@pclin040.win.tue.nl>
References: <20030806150335.GA5430@gondor.com>
	 <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl>
	 <20030810205513.GA6337@gondor.com>
	 <20030810231955.A16852@pclin040.win.tue.nl>
	 <20030810213450.GA7050@gondor.com>
	 <20030810235834.A16865@pclin040.win.tue.nl>
	 <20030810221020.GA7832@gondor.com>
	 <20030811003343.A16918@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 16:36:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-10 at 23:33, Andries Brouwer wrote:
>         if (drive->addressing == 1)             /* 48-bit LBA */
>                 return lba_48_rw_disk(drive, rq, (unsigned long long) block);
>         if (drive->select.b.lba)                /* 28-bit LBA */
>                 return lba_28_rw_disk(drive, rq, (unsigned long) block);
>         return chs_rw_disk(drive, rq, (unsigned long) block);
> 
> with checking the size of block.
> And init_idedisk_capacity() does not check addressing.

It should also issue LBA28 if the size of th range and the end block
fall under the LBA28 limit because thst saves you valuable I/O time.

Jens had patches for that but I don't know where they went in 2.6

