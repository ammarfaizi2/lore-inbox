Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTDQUcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbTDQUcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:32:45 -0400
Received: from [12.47.58.203] ([12.47.58.203]:54227 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262594AbTDQUcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:32:43 -0400
Date: Thu, 17 Apr 2003 13:45:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: rostedt@stny.rr.com, linux-kernel@vger.kernel.org, srostedt@goodmis.org
Subject: Re: What's the reason that /dev/mem can't map unreserved RAM?
Message-Id: <20030417134512.1623a926.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304172036540.1966-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304171414470.13337-100000@localhost.localdomain>
	<Pine.LNX.4.44.0304172036540.1966-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 20:44:34.0455 (UTC) FILETIME=[27665270:01C30522]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> I did start out on eliminating PageReserved a few months ago,
> but was persuaded to delay that until 2.7.  When that's done,
> you will be able to mmap /dev/mem properly.

I think we can almost do it now.  Just a few things like get_user_pages(),
ptrace and core dumping may need to be taught about VM_RESERVED.

Or we could simply change mmap_mem() to set VM_IO if any of the pages aren't
valid.  That's probably an accurate reflection of what the app is trying to
do, too.

