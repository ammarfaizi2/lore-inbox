Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWDYGuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWDYGuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWDYGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:50:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:667 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751399AbWDYGue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:50:34 -0400
From: Neil Brown <neilb@suse.de>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Date: Tue, 25 Apr 2006 16:50:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17485.50850.9186.130696@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [patch 1/2] raid6_end_write_request() spinlock fix
In-Reply-To: message from Coywolf Qi Hunt on Tuesday April 25
References: <20060425033542.GA4087@localhost.localdomain>
	<17485.45069.692725.551853@cse.unsw.edu.au>
	<20060425064310.GA29950@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 25, qiyong@fc-cn.com wrote:
> On Tue, Apr 25, 2006 at 03:13:49PM +1000, Neil Brown wrote:
> > On Tuesday April 25, qiyong@fc-cn.com wrote:
> > > Hello,
> > > 
> > > Reduce the raid6_end_write_request() spinlock window.
> > 
> > Andrew: please don't include these in -mm.  This one and the
> > corresponding raid5 are wrong, and I'm not sure yet the unplug_device
> > changes.
> 
> I am sure with the unplug_device. Just look follow the path...
> 

What path?  There are probably several.  If I follow the path, will I
see the same things as you see?  Who knows, because you haven't
bothered to tell us what you see.

> 
> Yes. Let's fix the error(). In any case, the current code is broken. (see raid5/6_end_read_request)

What will I see in raidX_end_read_request.  Surely it isn't that hard
to write a few more sentences?


> Comments? Thanks.

conf->working_disks isn't atomic_t and so decrementing without a
spinlock isn't safe.  So lets just leave it all inside a spinlock.

Also I have a vague memory that clearing In_sync before Faulty is
important, but I'm not certain of that.

Remember: the code is there for a reason.  It might not be a good
reason, and the code could well be wrong.  But it would be worth your
effort trying to find out what the reason is before blithely changing
it (as I discovered recently with a change I suggested to
invalidate_mapping_pages).

NeilBrown
