Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269619AbUI3Xnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbUI3Xnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUI3Xnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:43:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:64416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269619AbUI3Xnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:43:50 -0400
Date: Thu, 30 Sep 2004 16:47:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mlockall(MCL_FUTURE) unlocks currently locked
 mappings
Message-Id: <20040930164744.30db3fdc.akpm@osdl.org>
In-Reply-To: <20040929114244.Q1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> Calling mlockall(MCL_FUTURE) will erroneously unlock any currently locked
> mappings.  Fix this up, and while we're at it, remove the essentially
> unused error variable.

eek.

I've always assumed that mlockall(MCL_FUTURE) pins all your current pages
as well as future ones.  But no, that's what MCL_CURRENT|MCL_FUTURE does.

So when we fix this bug, we'll break my buggy test apps.

I wonder what other apps we'll break?
