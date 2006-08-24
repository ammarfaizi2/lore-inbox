Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWHXHu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWHXHu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWHXHu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:50:57 -0400
Received: from mail.suse.de ([195.135.220.2]:28630 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750772AbWHXHu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:50:57 -0400
From: Neil Brown <neilb@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Date: Thu, 24 Aug 2006 17:50:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17645.23129.674328.872688@cse.unsw.edu.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] nfsd: lockdep annotation
In-Reply-To: message from Arjan van de Ven on Thursday August 24
References: <1156330112.3382.34.camel@twins>
	<17645.17252.217583.660976@cse.unsw.edu.au>
	<1156404952.3014.0.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 24, arjan@infradead.org wrote:
> On Thu, 2006-08-24 at 16:12 +1000, Neil Brown wrote:
> > 
> > I had flags the fh_lock in nfsd_setattr a I_MUTEX_CHILD which you
> > didn't however I see that isn't needed (Why do we have PARENT and
> > CHILD and NORMAL.... you would think that any two would do ??)
> 
> for cross directory renames 3 are needed ;(

I see....
If one of the source/dest directories is an ancestor to the other
it gets _PARENT while the descendent gets _CHILD,
otherwise the destination gets _PARENT and the source gets _CHILD.
I guess the terms 'PARENT' and 'CHILD' refer more to the relationship
of the locks than the relationship of the directories.

(If the destination name exists, it gets locked with _NORMAL)

I still find the terminology a bit confusing.
 _GRANDPARENT -> _PARENT -> _NORMAL

would make more sense to me, but maybe it isn't that important.

Thanks for the explanation.

NeilBrown
