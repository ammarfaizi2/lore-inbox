Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWEBXrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWEBXrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEBXrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:47:37 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:53597 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964948AbWEBXrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:47:36 -0400
Date: Tue, 2 May 2006 16:47:22 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] JBD checkpoint cleanup strikes back
Message-ID: <20060502234721.GA5768@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060502184646.GK14703@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502184646.GK14703@atrey.karlin.mff.cuni.cz>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 08:46:46PM +0200, Jan Kara wrote:
>   The patch was already in 2.6.16-rc3 but was dropped because of
> problems with OCFS2. I've now tracked down the problem - OCFS2 relies on
> the fact that buffer does not have journal_head if it is not on any
> transaction's list. It assumes that if the buffer has buffer_jbd set,
> then it is journaled and hence the node has uptodate data in the
> buffer. My patch broke that assumption as in one path I forgot to call
> journal_remove_journal_head() and hence I was leaving behind some
> buffers not attached to any transaction but with journal_head. Now that
> leak is fixed and OCFS2 seems to work fine also with my patch.
Ahh, ok that makes sense and it definitely sounds like the type of thing
that would cause OCFS2 to pick up stale data.

>   Andrew, could you please put the patch into -mm? Thanks.
Without commenting any further on the patch, I can definitely offer up some
more testing on my end should Andrew decide to pick this up.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
