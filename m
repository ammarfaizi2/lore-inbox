Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUKVWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUKVWbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbUKVWam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:30:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5812 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262448AbUKVW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:27:35 -0500
Date: Mon, 22 Nov 2004 14:27:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Linus Torvalds wrote:

> The alternative is to just add a simple list into the task_struct and the
> head of it into mm_struct. Then, at fork, you just finish the fork() with
>
> 	list_add(p->mm_list, p->mm->thread_list);
>
> and do the proper list_del() in exit_mm() or wherever.
>
> You'll still loop in /proc, but you'll do the minimal loop necessary.

I think the approach that I posted is simpler unless there are other
benefits to be gained if it would be easy to figure out which tasks use an
mm.

