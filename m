Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUCRFni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 00:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUCRFni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 00:43:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:14558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262400AbUCRFnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 00:43:35 -0500
Date: Wed, 17 Mar 2004 21:43:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 ext3fs half order of magnitude slower than xfs - bulk
 write
Message-Id: <20040317214331.420a9cc1.akpm@osdl.org>
In-Reply-To: <20040316015445.GA17564@merlin.emma.line.org>
References: <20040315214741.GA5042@merlin.emma.line.org>
	<20040315152355.32a1b054.akpm@osdl.org>
	<20040316015445.GA17564@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
>
> Andrew Morton:
> 
> > It should be possible to generate a simple testcase which demonstrates this
> > problem on that machine.  Is that something you can do?
> > 
> > From your description, write-and-fsync.c from
> > 
> > 	http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> > 
> > would be a good starting point.
> 
> I've run "write-and-fsync -m SIZE -f SOMEFILE" where size is given in
> each section and SOMEFILE was chosen for some real-life but idle file
> system. I hope this is what you meant. I did one run per test.

Cannot reproduce, sorry.  Kernel is 2.6.5-rc1, disk is a "MAXTOR 6L080J4"


time write-and-fsync -m 256 -f foo

writeback caching off, ext3/ordered:
  write-and-fsync -m 256 -f foo  0.00s user 1.19s system 4% cpu 24.247 total

writeback caching off, XFS:
  write-and-fsync -m 256 -f foo  0.00s user 0.57s system 2% cpu 24.041 total

writeback caching on, ext3/ordered:
  write-and-fsync -m 256 -f foo  0.00s user 1.16s system 14% cpu 8.169 total

writeback caching on, XFS:
  write-and-fsync -m 256 -f foo  0.00s user 0.58s system 8% cpu 6.950 total
  write-and-fsync -m 256 -f foo  0.00s user 0.54s system 6% cpu 8.109 total
  write-and-fsync -m 256 -f foo  0.00s user 0.55s system 5% cpu 10.057 total
  write-and-fsync -m 256 -f foo  0.00s user 0.56s system 8% cpu 6.870 total

(quite some variability in XFS)


So...   Maybe you could test some other disks or something?
