Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTEUQXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTEUQXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:23:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6134 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262193AbTEUQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:23:06 -0400
Date: Wed, 21 May 2003 09:38:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: sct@redhat.com, bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
Message-Id: <20030521093848.59ada625.akpm@digeo.com>
In-Reply-To: <87addhd2mc.fsf@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 16:36:09.0138 (UTC) FILETIME=[152EF120:01C31FB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> looks Andrew Morton should return BKL in ext3_get_block_handle() in -mm tree?
>  this BKL protects ext3_alloc_branch() -> ext3_alloc_block() -> ext3_new_block()
>  call chain. or we may implement new protection schema where each jh has some
>  reference alike 'used by transaction N'

Can this be solved by spinlocking the relevant buffer_head, in a similar
way to your recent changes to journal_add_journal_head()?
