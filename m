Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTLaKwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLaKwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:52:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:2286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264246AbTLaKwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:52:49 -0500
Date: Wed, 31 Dec 2003 02:53:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20031231025309.6bc8ca20.akpm@osdl.org>
In-Reply-To: <20031231104801.GB4099@in.ibm.com>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	<20031216180319.6d9670e4.akpm@osdl.org>
	<20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> If PG_writeback is not set, it moves on to process the next page -- without
>  falling through to wait_on_page_writeback, isn't that so ? 
>  Another thread could have pulled the page off io_pages, put it on locked
>  pages, and not set PG_writeback as yet.

OK, so a (well commented!) lock_page() in filemap_fdatawait() would seem to
plug that.  I recall being worried that this might be livelockable against
ongoing read activity, but that doesn't sound right - such pages won't be
on locked_pages().

