Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUCRTKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUCRTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:10:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:63451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbUCRTKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:10:10 -0500
Subject: Re: 2.6.4-mm2
From: Daniel McNeil <daniel@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079635678.4185.2100.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
	 <1079485055.4181.1115.camel@watt.suse.com>
	 <1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	 <20040316180043.441e8150.akpm@osdl.org>
	 <1079554288.4183.1938.camel@watt.suse.com>
	 <20040317123324.46411197.akpm@osdl.org>
	 <1079563568.4185.1947.camel@watt.suse.com>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
	 <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
	 <1079632431.6930.30.camel@ibm-c.pdx.osdl.net>
	 <1079635678.4185.2100.camel@watt.suse.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Mar 2004 11:10:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 10:47, Chris Mason wrote:
> On Thu, 2004-03-18 at 12:53, Daniel McNeil wrote:
> > I'm ran 2.6.4-mm2 plus the 2 wait_on_page_range() patches,
> > the test_set_page_writeback() patch and clear_page_dirty_for_io patch
> > overnight.
> > 
> > 6 copies of direct_read_under test on 8-cpu system on 1
> > ext3 file system in 1 directory on a scsi disk.
> > (http://developer.osdl.org/daniel/AIO/TESTS/direct_read_under.c)
> > 
> > 5 of the 6 tests saw uninitialized data within 2 hours.
> > The sixth test ran overnight.
> 
> Do you still have the errors generated?  I wondering how big the range
> of uninitialized data was.  When I was bug hunting yesterday, I saw
> ranges from 64k to 32mb in size, which was why I decided writes weren't
> getting to the disk at all.
> 
> It might be interesting to try with data=writeback, or on ext2.  Things
> might be easier to track if we're not worried about ll_rw_block.
> 
> It might also be interesting to significantly lower the size of the
> reads and writes done by direct_read_under, or anything else you can
> think of to get the reproduce time down to something smaller than 2
> hours...
> 
> It's probably a good idea to upgrade to 2.6.5-rc1-mm2, just so we're all
> staring at the same code.
> 
> -chris
> 

Chris,

Still have the data:
		 63 pages (258048 bytes)
		 90 pages (368640 bytes)
		139 pages (569344 bytes)
		 30 pages (122880 bytes)
		 87 pages (356352 bytes)
		

I'm rebooting to 2.6.5-rc1-mm2 and will re-run.  I have do have
versions of direct_read_under that do smaller i/o and also
1 that does forks off and does 'sync' calls every few seconds.

I'll give ext2 and try as well.

Daniel

