Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUCUOej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUCUOej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:34:39 -0500
Received: from ns.suse.de ([195.135.220.2]:36287 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263655AbUCUOeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:34:37 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under
From: Chris Mason <mason@suse.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
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
	 <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
	 <1079714990.6930.49.camel@ibm-c.pdx.osdl.net>
	 <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1079879799.11062.348.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 09:36:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 12:05, Daniel McNeil wrote:
> Can't type this morning -- 2.6.5-rc1-mm2 is what I ran on.
>                            =============
> 
> Daniel
> On Fri, 2004-03-19 at 08:49, Daniel McNeil wrote:
> > I re-ran direct_read_under test (6 copies) on 2.6.4-rc1-mm2:
> > 
> > ext3 failed within 2 hours.
> > 
> > ext2 ran overnight without errors.
> > 
[ ... a slightly different kernel, but numbers are probably good ]

> > > 
> > > Still have the data:
> > > 		 63 pages (258048 bytes)
> > > 		 90 pages (368640 bytes)
> > > 		139 pages (569344 bytes)
> > > 		 30 pages (122880 bytes)
> > > 		 87 pages (356352 bytes)
> > > 		
> > 

That seems like a lot of pages for a small race, it feels like we have a
bigger problem.  If nobody else has ideas, and you've got an available
disk for mkreiserfs, could I talk you into trying with reiserfs
data=ordered?

ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.4

(use series.mm for a list of files to apply to 2.6.5-rc-mm)

data=ordered is the default with those patches, so just mkreiserfs and
mount.  reiserfs is using a different writepage and different code to
submit the ordered buffers, so you'll be using completely different code
paths.

I'll try to get some time on an 8way here for some tests as well.

-chris


