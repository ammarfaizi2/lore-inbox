Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTF3SKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTF3SKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:10:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:43559 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265667AbTF3SKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:10:06 -0400
Date: Mon, 30 Jun 2003 11:19:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: mbligh@aracnet.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm1 falling over in SDET
Message-Id: <20030630111926.5d883a3b.akpm@digeo.com>
In-Reply-To: <20030630130432.GD4065@in.ibm.com>
References: <20030628170235.51ee2f69.akpm@digeo.com>
	<1056857338.2514.4.camel@mulgrave>
	<6620000.1056864944@[10.10.2.4]>
	<20030630101719.GC4065@in.ibm.com>
	<20030630130432.GD4065@in.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2003 18:24:27.0521 (UTC) FILETIME=[D70B7F10:01C33F34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> > I tried sdet on 16-way numaq with 2.5.73-mm2. It completes the run on ext2 
> > (no OOMs), but gives following oops while running on ext3
> > 
> 
> Looks like that was some one off oops.. on second iteration I could run
> sdet on ext3 also without any oops or oom.

No, I think that assertion failure in journal_dirty_metadata() was more
than a once off, whatever that is.  There is probably something wrong in
there, but from a moderate-sized look I cannot see what it is.

Unless inspiration strikes we will need to wait until someone can hit it
with some sort of repeatability and then run with the ext3-debug patch
applied and enabled.

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.73/ext3-debug.patch

This will give a trace of what happened to that buffer and should allow me
to fix the bug.

