Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCWAvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUCWAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:51:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:24286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbUCWAvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:51:13 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040322151312.6b629736.akpm@osdl.org>
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
	 <20040322151312.6b629736.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080003067.6930.78.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2004 16:51:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The test has been running over 5 hours now without seeing uninitialized
data.  I'll let it run overnight, but it looks like the small 
__block_write_full_page patch fixes the problem.

Daniel

On Mon, 2004-03-22 at 15:13, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > I was thinking about this also, since this is included in the patch.
> > As long as the page stays dirty in radix tree so the sync writer
> > can find it, then the sync writer can wait on the locked buffers.
> > 
> > I am giving it a try and will let you know.
> 
> Please do.
> 
> Redirtyng the pages in this manner does mean that background_writeout()
> could get stuck in a loop trying to write the same batch of pages over and
> over again, until the I/O completes.
> 
> I'll take another look at marking the pages which back the ll_rw_blk
> buffers as being under writeback.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

