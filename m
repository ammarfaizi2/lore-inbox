Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUCWVry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCWVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:47:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:30434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262866AbUCWVrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:47:46 -0500
Date: Tue, 23 Mar 2004 13:47:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: mason@suse.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
Message-Id: <20040323134745.37c3e847.akpm@osdl.org>
In-Reply-To: <1080077881.2410.18.camel@ibm-c.pdx.osdl.net>
References: <20040314172809.31bd72f7.akpm@osdl.org>
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
	<1080003067.6930.78.camel@ibm-c.pdx.osdl.net>
	<20040323012514.7670f622.akpm@osdl.org>
	<1080061501.6930.84.camel@ibm-c.pdx.osdl.net>
	<20040323095953.72786ccc.akpm@osdl.org>
	<1080077881.2410.18.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
>  It looks like every place wbc->nonblocking is set to 1, sync_mode
>  is set to WB_SYNC_NONE, but there are places where WB_SYNC_NONE is
>  used and nonblocking is NOT set: 
>  	balance_dirty_pages()
>  	try_to_unuse()
> 
>  So your patch makes balance_dirty_pages() do the lock_buffer()
>  in __block_write_full_page() instead of skipping and redirtying
>  the page.
> 
>  I just making sure I understand.
>  So, WB_SYNC_ALL and nonblocking=1 should never be used?

Correct, setting both WB_SYNC_ALL and nonblocking=1 doesn't make sense.
