Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUGBQxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUGBQxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUGBQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:53:36 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:29655 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S264723AbUGBQxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:53:33 -0400
Date: Fri, 2 Jul 2004 09:53:26 -0700 (PDT)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@kaki.stanford.edu
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040702011525.1f0d0829.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407020948350.23611-100000@kaki.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, it missed the locking semantics of sem_revalidate. I'll look into
designing a spec language to teach the tool about simple cases like this..
-yichen

On Fri, 2 Jul 2004, Andrew Morton wrote:

> Yichen Xie <yxie@cs.stanford.edu> wrote:
> >
> >     http://glide.stanford.edu/linux-lock/err1.html (69 errors)
> 
> ipc/sem.c:find_undo() seems to be a false positive.  That function calls
> sem_revalidate() which may or may not require a sem_unlock() afterwards,
> depending on what value it returned.
> 
> I'm not sure it's worth teaching the tool about this - I'd refer to
> strangle the IPC code.
> 

