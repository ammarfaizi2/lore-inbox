Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWESPFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWESPFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWESPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:05:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932336AbWESPFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:05:48 -0400
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: Jan Kara <jack@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <446DBB31.6010101@bull.net>
References: <446C2F89.5020300@bull.net>
	 <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
	 <446C8EB1.3090905@bull.net>
	 <20060519013023.GA11424@atrey.karlin.mff.cuni.cz>
	 <446DBB31.6010101@bull.net>
Content-Type: text/plain
Date: Fri, 19 May 2006 16:05:27 +0100
Message-Id: <1148051127.5156.28.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-05-19 at 14:33 +0200, Zoltan Menyhart wrote:

> >   For two of the above comments: Under memory pressure data buffers can
> > be written out earlier and then released by __journal_try_to_free_buffer()
> > as they are not dirty any more. The above checks protect us against this.
> 
> Assume "bh" has been set free in the mean time.
> Assume it is now used for another transaction (maybe for another file system).

I don't follow --- we already have a refcount to the bh, how can it be
reused?  We took the j_list_lock first, then looked up the jh on this
transaction's sync data list, then did the get_bh() without dropping
j_list_lock; so by the time we take the refcount, the j_list_lock
ensures it cannot have come off this transaction.  And subsequently, the
refcount prevents reuse.

--Stephen


