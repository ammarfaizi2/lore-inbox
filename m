Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUCQXZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUCQXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:25:42 -0500
Received: from ns.suse.de ([195.135.220.2]:4842 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262169AbUCQXZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:25:33 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20040317150909.7fd121bd.akpm@osdl.org>
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
Content-Type: text/plain
Message-Id: <1079566076.4186.1959.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 18:27:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 18:09, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > wait_on_page_writeback_range() does a pagevec_lookup_tag on 
> >  min(end - index + 1, (pgoff_t)PAGEVEC_SIZE)
> > 
> >  Which translates to: (unsigned long)-1 - 0 + 1, which is 0.
> 
> I made a mental note to test that code.
> 
> How's this look?
> 

Looks good, but I'm still having problems convincing pagevec_lookup_tag
to return anything other than 0 when called from
wait_on_page_writeback_range (ext2, ext3, reiserfs).  Any ideas?

I'm running with all the fixes discussed so far, including
clear_page_dirty_for_io(page)

-chris


