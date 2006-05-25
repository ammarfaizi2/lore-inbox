Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWEYMYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWEYMYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWEYMYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:24:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:64680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965129AbWEYMYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:24:22 -0400
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Thu, 25 May 2006 22:24:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17525.41455.815969.582475@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 2] Prepare for __copy_from_user_inatomic to not zero missed bytes. 
In-Reply-To: message from David Howells on Thursday May 25
References: <1060522044652.31268@suse.de>
	<20060522143524.25410.patches@notabene>
	<19591.1148558343@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 25, dhowells@redhat.com wrote:
> 
> NeilBrown <neilb@suse.de> wrote:
> 
> > Interestingly 'frv' disables preempt in kmap_atomic, but its
> > copy_from_user doesn't expect faults and never zeros the tail...
> 
> What gives you the idea that copy_from_user() on FRV doesn't expect or handle
> faults when CONFIG_MMU is set?  And why do you say it never zeroes the tail?
> 
> David

Sloppy reading of the code I expect :-(  I was probably expecting it
to look more like what I had seen in other ARCHs.

Have looked more closely, I see that it does expect and handle faults,
and copy_from_user does zero the tail, however __copy_from_user*
does not zero the tail and this is what filemap_copy_from_user
and ntfs_copy_user* actually use, so on that arch, we seem
to fail the other way - we don't zero the tail sometimes when
we should.

Thanks for reading the patch and asking the question.

NeilBrown
