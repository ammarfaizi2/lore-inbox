Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWHKWN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWHKWN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWHKWN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:13:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62147 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964793AbWHKWN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:13:27 -0400
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060810110047.af273a55.akpm@osdl.org>
References: <1155172827.3161.80.camel@localhost.localdomain>
	 <20060809233940.50162afb.akpm@osdl.org> <20060810171755.GA19238@thunk.org>
	 <20060810110047.af273a55.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 11 Aug 2006 15:13:09 -0700
Message-Id: <1155334389.3765.18.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 11:00 -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 13:17:55 -0400
> Theodore Tso <tytso@mit.edu> wrote:
> 
> > On Wed, Aug 09, 2006 at 11:39:40PM -0700, Andrew Morton wrote:
> > > - replace all brelse() calls with put_bh().  Because brelse() is
> > >   old-fashioned, has a weird name and neelessly permits a NULL arg.
> > > 
> > >   In fact it would be beter to convert JBD and ext3 to put_bh before
> > >   copying it all over.
> > 
> > Wouldn't it be better to preserve in the source code history the
> > brelse->put_bh conversion?  We can pour a huge number of changes in
> > ext4 before we submit, but I would have thought it would be easier for
> > everyone to see what is going on if we submit with just the minimal
> > changes, and then have patches that address concerns like this one at
> > a time.
> > 
> 
> I'd suggest that this be one of the cleanups which be done within ext3
> before taking the ext4 copy.


Looked at this today -- currently brelse() and __brelse() will check the
b_count before calling put_bh().  I think it's okay to replace put_bh()
without checking the b_count, as we always call put_bh() with get_bh
()....but want to confirm with you.

Mingming

