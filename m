Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTETMGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbTETMGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:06:18 -0400
Received: from tmi.comex.ru ([217.10.33.92]:22678 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263746AbTETMGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:06:18 -0400
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Date: Tue, 20 May 2003 16:06:19 +0000
Message-ID: <87addhd2mc.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hmm.
looks Andrew Morton should return BKL in ext3_get_block_handle() in -mm tree?
this BKL protects ext3_alloc_branch() -> ext3_alloc_block() -> ext3_new_block()
call chain. or we may implement new protection schema where each jh has some
reference alike 'used by transaction N'


Andrew?

>>>>> Stephen C Tweedie (SCT) writes:

 SCT> Not with BKL.  Without it, yes, that's definitely a risk, and you need
 SCT> some locking for the access to b_committed_data.  Without that, even if
 SCT> you keep the jh->b_committed_data field valid, you risk freeing the old
 SCT> copy that another thread is using.


