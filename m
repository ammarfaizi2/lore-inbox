Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUBFWhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266862AbUBFWhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:37:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:57780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266827AbUBFWh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:37:29 -0500
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat" DIO read race still fails
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <200402051558.08927.pbadari@us.ibm.com>
References: <20040205014405.5a2cf529.akpm@osdl.org>
	 <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
	 <200402051558.08927.pbadari@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076107043.7182.146.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Feb 2004 14:37:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I patched 2.6.2-mm1 with the wait_on_buffer(bh) in
__block_write_full_page() and my tests ran overnight and
though today without any errors.

I'm looking to see if there is any way to move the end_page_writeback()
for this locked bh case to the end_buffer_write_sync().  Kind of
tricky...

Daniel


On Thu, 2004-02-05 at 15:58, Badari Pulavarty wrote:
> On Thursday 05 February 2004 03:31 pm, Daniel McNeil wrote:
> > Andrew,
> >
> > I tested 2.6.2-mm1 on an 8-proc running 6 copies of the read_under
> > test and all 6 read_under tests saw uninitialized data in less than 5
> > minutes. :(
> >
> > Daniel
> 
> Daniel,
> 
> Same here... Just FYI, I am running with your original patch and
> not failed so far (2 hours..) Normally, I see the problem in 15 min or so.
> 
> Thanks,
> Badari

