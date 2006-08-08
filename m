Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWHHXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWHHXcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHHXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:32:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29112 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965076AbWHHXcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:32:31 -0400
From: Neil Brown <neilb@suse.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 9 Aug 2006 08:33:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17625.4404.778981.728665@cse.unsw.edu.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
In-Reply-To: message from Krzysztof Halasa on Tuesday August 8
References: <or8xlztvn8.fsf@redhat.com>
	<17624.29070.246605.213021@cse.unsw.edu.au>
	<44D8732C.2060207@tls.msk.ru>
	<m3fyg7m40e.fsf@defiant.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 8, khc@pm.waw.pl wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> > Why we're updating it BACKWARD in the first place?
> 
> Another scenario: 1 disk (of 2) is removed, another is added, RAID-1
> is rebuilt, then the disk added last is removed and replaced by
> the disk which was removed first. Would it trigger this problem?
> 

No.  The removing and the adding will all move the event count clearly
forward and the removed drive will have an old event count and so will
not be considered for easy inclusion.


> > Also, why, when we adding something to the array, the event counter is
> > checked -- should it resync regardless?
> 
> I think it's a full start, not a hot add. For hot add contents of
> the new disk should be ignored.

See my other post for why I want to sometimes not do a recovery on a
hot-add.

NeilBrown
