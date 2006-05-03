Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWECKZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWECKZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 06:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWECKZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 06:25:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22167 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965142AbWECKZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 06:25:54 -0400
Date: Wed, 3 May 2006 12:25:53 +0200
From: Jan Kara <jack@suse.cz>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] JBD checkpoint cleanup strikes back
Message-ID: <20060503102552.GG14806@atrey.karlin.mff.cuni.cz>
References: <20060502184646.GK14703@atrey.karlin.mff.cuni.cz> <20060502234721.GA5768@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502234721.GA5768@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 02, 2006 at 08:46:46PM +0200, Jan Kara wrote:
> >   The patch was already in 2.6.16-rc3 but was dropped because of
> > problems with OCFS2. I've now tracked down the problem - OCFS2 relies on
> > the fact that buffer does not have journal_head if it is not on any
> > transaction's list. It assumes that if the buffer has buffer_jbd set,
> > then it is journaled and hence the node has uptodate data in the
> > buffer. My patch broke that assumption as in one path I forgot to call
> > journal_remove_journal_head() and hence I was leaving behind some
> > buffers not attached to any transaction but with journal_head. Now that
> > leak is fixed and OCFS2 seems to work fine also with my patch.
> Ahh, ok that makes sense and it definitely sounds like the type of thing
> that would cause OCFS2 to pick up stale data.
> 
> >   Andrew, could you please put the patch into -mm? Thanks.
> Without commenting any further on the patch, I can definitely offer up some
> more testing on my end should Andrew decide to pick this up.
  Testing is always welcome :). Thanks. I did some basic one myself but
the more tests the better.

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
