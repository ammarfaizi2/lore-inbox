Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUCHAlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUCHAlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:41:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:54186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262274AbUCHAk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:40:59 -0500
Date: Sun, 7 Mar 2004 16:40:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-Id: <20040307164052.0c8a212b.akpm@osdl.org>
In-Reply-To: <20040307144921.GA189@elf.ucw.cz>
References: <20040307144921.GA189@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> For swsusp, I need to free as much memory as possible. Well, and it
> would be great if no highmem pages remained, so that I would not have
> to deal with that. Is that possible?

No, it isn't.  There are pagetable pages and mlocked user pages which we
cannot do anything with.

We could perhaps swap out the mlocked pages anyway if a suspend is in
progress, but the highmem pagetable pages are not presently reclaimed
by the VM.

