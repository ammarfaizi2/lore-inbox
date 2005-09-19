Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVISUrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVISUrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVISUrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:47:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbVISUrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:47:52 -0400
Date: Mon, 19 Sep 2005 13:47:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Smarduch Mario-CMS063 <CMS063@motorola.com>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: RE: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <A752C16E6296D711942200065BFCB6942521C78F@il02exm10>
Message-ID: <Pine.LNX.4.58.0509191343540.2553@g5.osdl.org>
References: <A752C16E6296D711942200065BFCB6942521C78F@il02exm10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, Smarduch Mario-CMS063 wrote:
>
> But I don't see the samething in 2.4.31 (which what we're using now).

I'm pretty sure 2.4.x should have the mmap_sem too.

But I think there it's aquired by the caller of dup_mmap() (ie it's 
"copy_mm()" that gets the mmap_sem and holds it for the duration of 
dup_mmap).

In fact, I'm sure: the mmap_sem was changed from a regular semaphore to a
read-write semaphore in 2.4.2.5, and we definitely took it around
dup_mmap() at that point. 

Of course, maybe some broken change removed it later in 2.4.x, I don't 
keep a current 2.4.x tree around.

		Linus
