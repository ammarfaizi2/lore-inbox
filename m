Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWJLGnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWJLGnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWJLGnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:43:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161220AbWJLGnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:43:39 -0400
Date: Wed, 11 Oct 2006 23:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitriy Monakhov <dmonakhov@openvz.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, <devel@openvz.org>,
       ext2-devel@lists.sourceforge.net, Andrey Savochkin <saw@swsoft.com>
Subject: Re: [RFC][PATCH] EXT3: problem with page fault inside a transaction
Message-Id: <20061011234330.efae4265.akpm@osdl.org>
In-Reply-To: <87mz82vzy1.fsf@sw.ru>
References: <87mz82vzy1.fsf@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 09:57:26 +0400
Dmitriy Monakhov <dmonakhov@openvz.org> wrote:

> While reading Andrew's generic_file_buffered_write patches i've remembered
> one more EXT3 issue.journal_start() in prepare_write() causes different ranking
> violations if copy_from_user() triggers a page fault. It could cause 
> GFP_FS allocation, re-entering into ext3 code possibly with a different
> superblock and journal, ranking violation of journalling serialization 
> and mmap_sem and page lock and all other kinds of funny consequences.

With the stuff Nick and I are looking at, we won't take pagefaults inside
prepare_write()/commit_write() any more.

> Our customers complain about this issue.

Really?  How often?

What on earth are they doing to trigger this?  writev() without the 2.6.18
writev() bugfix?
