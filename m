Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWHALiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWHALiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWHALiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:38:55 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:58380 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S1161391AbWHALix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:38:53 -0400
Subject: Re: reiser4: maybe just fix bugs?
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda.linux@googlemail.com>, linux-kernel@vger.kernel.org,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
In-Reply-To: <44CEBA0A.3060206@namesys.com>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
	 <20060801013104.f7557fb1.akpm@osdl.org>  <44CEBA0A.3060206@namesys.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 15:24:37 +0400
Message-Id: <1154431477.10043.55.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2006-07-31 at 20:18 -0600, Hans Reiser wrote:
> Andrew Morton wrote:

> >The writeout code is ugly, although that's largely due to a mismatch between
> >what reiser4 wants to do and what the VFS/MM expects it to do.

Yes. reiser4 writeouts atoms. Most of pages get into atoms via
sys_write. But pages dirtied via shared mapping do not. They get into
atoms in reiser4's writepages address space operation. That is why
reiser4_sync_inodes has two steps: on first one it calls
generic_sync_sb_inodes to call writepages for dirty inodes to capture
pages dirtied via shared mapping into atoms. Second step flushes atoms.

> >
> I agree --- both with it being ugly, and that being part of why.
> 
> >  If it
> >works, we can live with it, although perhaps the VFS could be made smarter.
> >  
> >
> I would be curious regarding any ideas on that.  Next time I read
> through that code, I will keep in mind that you are open to making VFS
> changes if it improves things, and I will try to get clever somehow and
> send it by you.  Our squalloc code though is I must say the most
> complicated and ugliest piece of code I ever worked on for which every
> cumulative ugliness had a substantive performance advantage requiring us
> to keep it.  If you spare yourself from reading that, it is
> understandable to do so.
> 
> >I'd say that resier4's major problem is the lack of xattrs, acls and
> >direct-io.  That's likely to significantly limit its vendor uptake. 

xattrs is really a problem.



