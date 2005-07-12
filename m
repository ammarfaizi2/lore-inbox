Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVGLNXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVGLNXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGLNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:23:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12211 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261313AbVGLNXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:23:36 -0400
Date: Tue, 12 Jul 2005 15:23:28 +0200
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix race in do_get_write_access()
Message-ID: <20050712132328.GD27000@atrey.karlin.mff.cuni.cz>
References: <20050711161011.GA28238@atrey.karlin.mff.cuni.cz> <1121110288.1871.233.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121110288.1871.233.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Mon, 2005-07-11 at 17:10, Jan Kara wrote:
> 
> >   attached patch should fix the following race:
> ...
> >   and we have sent wrong data to disk... We now clean the dirty buffer
> > flag under buffer lock in all cases and hence we know that whenever a buffer
> > is starting to be journaled we either finish the pending write-out
> > before attaching a buffer to a transaction or we won't write the buffer
> > until the transaction is going to be committed... Please apply.
> 
> Looks good to me.
> 
> Btw, how did you find this?  Were you able to reproduce this in
> practice?
  I was not able to reproduce the problem in practice (not that I'd try
very much). When I was fixing the checkpointing code I noted that
ll_rw_block() need not actually send data to disk because of buffer
being locked. So I started inspecting how do we actually use buffer
lock and found this problem...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
