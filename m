Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUCRA2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCRA2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:28:44 -0500
Received: from ns.suse.de ([195.135.220.2]:10908 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262235AbUCRA2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:28:41 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20040317161338.28b21c35.akpm@osdl.org>
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
Content-Type: text/plain
Message-Id: <1079569870.4186.1967.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 19:31:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 19:13, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > On Wed, 2004-03-17 at 18:51, Andrew Morton wrote:
> > > Chris Mason <mason@suse.com> wrote:
> > > >
> > > > Looks good, but I'm still having problems convincing pagevec_lookup_tag
> > > > to return anything other than 0 when called from
> > > > wait_on_page_writeback_range (ext2, ext3, reiserfs).  Any ideas?
> > > 
> > > This might help.  I'm testing this path now, so there may be more changes..
> > > 
> > 
> > Well, that's certainly a lot slower ;-)
> 
> For once, that's good.
> 
> > I've got a direct_read_under
> > round going.  While you're at it, there's one more bug.
> > 
> > The wbc struct used by filemap_fdatawrite doesn't initialize
> > wbc.nonblocking to zero.  stack magic might give us a 1 there, leading
> > to an early exit from mpage_writepages even when doing a WB_SYNC_ALL.
> 
> I hope not.
> 

Yes, my brain wandered off for a bit.  Seems like it's break time for
chris...good news is that direct_read_under is still running without
problems here.

-chris


