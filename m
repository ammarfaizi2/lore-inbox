Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWGJNbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWGJNbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWGJNbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:31:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964959AbWGJNbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:31:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060710024657.GA255@oleg> 
References: <20060710024657.GA255@oleg> 
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/8] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 10 Jul 2006 14:31:31 +0100
Message-ID: <10872.1152538291@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Do you see any reason for tasklist_lock here (and in elf_core_dump) ?
> 
> do_each_thread() is rcu-safe, and all tasks which use this ->mm must
> sleep in wait_for_completion(&mm->core_done) at this point.

Hmmm... do_each_thread() does not call rcu_read_lock/unlock(), but you may
well be right.  What about kernel threads running on another CPU with
active_mm set to this mm (assuming I'm remembering correctly how that works)?
I'm not sure they'd be a problem, though.

It does sound like you've got a valid point, though.

David
