Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVEBEhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEBEhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 00:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEBEhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 00:37:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:41114 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261626AbVEBEhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 00:37:01 -0400
Date: Mon, 2 May 2005 10:16:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-ID: <20050502044627.GA4654@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com> <427280C1.8090404@us.ibm.com> <1114816980.10473.90.camel@localhost.localdomain> <20050430161043.GB3941@in.ibm.com> <20050430171111.GA4265@in.ibm.com> <1114884473.13725.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114884473.13725.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 11:07:53AM -0700, Mingming Cao wrote:
> On Sat, 2005-04-30 at 22:41 +0530, Suparna Bhattacharya wrote:
> > On Sat, Apr 30, 2005 at 09:40:43PM +0530, Suparna Bhattacharya wrote:
> > > On Fri, Apr 29, 2005 at 04:22:59PM -0700, Mingming Cao wrote:
> > > > On Fri, 2005-04-29 at 11:45 -0700, Badari Pulavarty wrote:
> > > > > I touch tested your patch earlier and seems to work fine. Lets integrate
> > > > > Mingming's getblocks() patches with this and see if we get any benifit
> > > > > from the whole effort.
> > > > > 
> > > > 
> > > > I tried Suparna's mpage_writepages_getblocks patch with my
> > > > ext3_get_blocks patch, seems to work fine,  except that still only one
> > > > block is allocated at a time. I got a little confused.... 
> > > > 
> > > > I did not see any delayed allocation code in your patch, I assume you
> > > > have to update ext3_prepare_write to not call ext3_get_block, so that
> > > > block allocation will be defered at ext3_writepages time. So without the
> > > > delayed allocation part, the get_blocks in mpage_writepages is doing
> > > > multiple blocks look up only, right?
> > > 
> > > That's right - so you could try it with mmapped writes (which don't
> > > go through a prepare write) or with Badari's patch to not call
> > > ext3_get_block in prepare write.
> > 
> > BTW, I hope you are running with NOBH.
> 
> No, it was not run with NOBH. Why we need to turn on nobh here?

If the page has buffers, then get_blocks won't be invoked -- it either
finds all the buffers in a page to be mapped contiguous, in which case
it can directly issue the IO or enters the confused case where it goes
through block_write_full_page.

> 
> There are some issue running fsx tests with both patches, w/o direct io
> option. I will spend more time on this next week.

OK, I can take a look at the fsx logs, just in case it is similar to
something I've seen before.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

