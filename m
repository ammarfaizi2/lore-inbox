Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbUKVWXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUKVWXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbUKVWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:23:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:3466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbUKVWWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:22:55 -0500
Date: Mon, 22 Nov 2004 14:22:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Christoph Lameter wrote:
> 
> The problem is then that the proc filesystem must do an extensive scan
> over all threads to find users of a certain mm_struct.

The alternative is to just add a simple list into the task_struct and the
head of it into mm_struct. Then, at fork, you just finish the fork() with

	list_add(p->mm_list, p->mm->thread_list);

and do the proper list_del() in exit_mm() or wherever.

You'll still loop in /proc, but you'll do the minimal loop necessary.

		Linus
