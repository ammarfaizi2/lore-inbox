Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCVXLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUCVXLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:11:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:49052 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261421AbUCVXLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:11:07 -0500
Date: Mon, 22 Mar 2004 15:13:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: mason@suse.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
Message-Id: <20040322151312.6b629736.akpm@osdl.org>
In-Reply-To: <1079981473.6930.71.camel@ibm-c.pdx.osdl.net>
References: <20040314172809.31bd72f7.akpm@osdl.org>
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
	<1079879799.11062.348.camel@watt.suse.com>
	<1079979016.6930.62.camel@ibm-c.pdx.osdl.net>
	<1079980512.11058.524.camel@watt.suse.com>
	<1079981473.6930.71.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> I was thinking about this also, since this is included in the patch.
> As long as the page stays dirty in radix tree so the sync writer
> can find it, then the sync writer can wait on the locked buffers.
> 
> I am giving it a try and will let you know.

Please do.

Redirtyng the pages in this manner does mean that background_writeout()
could get stuck in a loop trying to write the same batch of pages over and
over again, until the I/O completes.

I'll take another look at marking the pages which back the ll_rw_blk
buffers as being under writeback.

