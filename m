Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbTCTWI3>; Thu, 20 Mar 2003 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTCTWIV>; Thu, 20 Mar 2003 17:08:21 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6443 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262671AbTCTWHx>; Thu, 20 Mar 2003 17:07:53 -0500
Subject: Re: [Patch] ext3_journal_stop inode access
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030320161230.3c4e0f47.akpm@digeo.com>
References: <1048185825.2491.386.camel@sisko.scot.redhat.com>
	 <20030320131523.6c56d10f.akpm@digeo.com>
	 <1048196202.2491.603.camel@sisko.scot.redhat.com>
	 <20030320161230.3c4e0f47.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048198730.2491.626.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 20 Mar 2003 22:18:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,On Fri, 2003-03-21 at 00:12, Andrew Morton wrote:

> > Well, there's still the
> > 	if (err)
> > 		__ext3_std_error(inode->i_sb, where, err);
> > case in ext3_journal_stop() to worry about
> 
> We already have that.

Only if we fix the underlying problem --- I was only pointing out that
even if we drop the setting of s_dirt entirely, which was what we were
trying to fix, we can't avoid having to find the sb.

> But I'm not particularly fussed either way - it will only be 100-200 bytes of
> code saved.

Yep, but there are probably other places we can find where we can avoid
passing the sb around too if we have the back-pointer. I guess it makes
sense to go ahead with that.

> The journal and the superblock have a definite one-to-one relationship - I think the
> backpointer makes sense.  But whatever - I'll let you flip that coin.

OK, go for it and I'll merge for 2.4.

Cheers,
 Stephen

