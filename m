Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVD3QCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVD3QCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVD3QCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:02:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25283 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261271AbVD3QB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:01:29 -0400
Date: Sat, 30 Apr 2005 21:40:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-ID: <20050430161043.GB3941@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1113288087.4319.49.camel@localhost.localdomain> <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk> <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com> <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com> <427280C1.8090404@us.ibm.com> <1114816980.10473.90.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114816980.10473.90.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:22:59PM -0700, Mingming Cao wrote:
> On Fri, 2005-04-29 at 11:45 -0700, Badari Pulavarty wrote:
> > I touch tested your patch earlier and seems to work fine. Lets integrate
> > Mingming's getblocks() patches with this and see if we get any benifit
> > from the whole effort.
> > 
> 
> I tried Suparna's mpage_writepages_getblocks patch with my
> ext3_get_blocks patch, seems to work fine,  except that still only one
> block is allocated at a time. I got a little confused.... 
> 
> I did not see any delayed allocation code in your patch, I assume you
> have to update ext3_prepare_write to not call ext3_get_block, so that
> block allocation will be defered at ext3_writepages time. So without the
> delayed allocation part, the get_blocks in mpage_writepages is doing
> multiple blocks look up only, right?

That's right - so you could try it with mmapped writes (which don't
go through a prepare write) or with Badari's patch to not call
ext3_get_block in prepare write.

Regards
Suparna
> 
> 
> Mingming
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

