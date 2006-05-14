Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWENL6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWENL6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWENL6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:58:09 -0400
Received: from mx2.mail.ru ([194.67.23.122]:59407 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751405AbWENL6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:58:07 -0400
Date: Sun, 14 May 2006 16:01:13 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH 3/3] ufs: change b_blocknr
Message-ID: <20060514120113.GB6215@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060514100235.GA21341@rain.homenetwork> <20060514035801.4cb79d2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514035801.4cb79d2c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:58:01AM -0700, Andrew Morton wrote:
> Evgeniy Dushistov <dushistov@mail.ru> wrote:
> >
> > Because of ufs's layout, code which works with UFS should
> > time to time change such map "online":
> > physical location<-->logical inode block
> 
> It does?  You mean that certain parts of a file will get moved from one set
> of disk blocks to another?
> 
In short file: consist of several blocks and fragments.
sizeof(block)=8*sizeof(fragment),
fragments used to prevent unwanted waste of space.

When file is growing and we occupy 8 fragments in tail of it,
we should allocate whole block and move all 8 fragments to it.

In 2.2 I suppose such code works fine:
bh = sb_bread
bh->b_blocknr=newvalue
mark_buffer_dirty

I doubt that it is normal for 2.4,
and this was completely wrong for 2.6.

-- 
/Evgeniy

