Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUEGXb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUEGXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUEGXb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:31:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:18838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263843AbUEGXbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:31:25 -0400
Date: Fri, 7 May 2004 16:32:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-Id: <20040507163235.11cd94ce.akpm@osdl.org>
In-Reply-To: <20040507220654.GA32208@sgi.com>
References: <20040501120805.GA7767@sgi.com>
	<20040502182811.GA1244@us.ibm.com>
	<20040503184006.GA10721@sgi.com>
	<20040507205048.GB1246@us.ibm.com>
	<20040507220654.GA32208@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> The calls to RCU are coming from here:
> 
> 	[11]kdb> bt
> 	Stack traceback for pid 3553
> 	0xe00002b007230000     3553     3139  1   11   R  0xe00002b0072304f0 *ls
> 	0xa0000001000feee0 call_rcu
> 	0xa0000001001a3b20 d_free+0x80
> 	0xa0000001001a3ec0 dput+0x340
> 	0xa00000010016bcd0 __fput+0x210
> 	0xa00000010016baa0 fput+0x40
> 	0xa000000100168760 filp_close+0xc0
> 	0xa000000100168960 sys_close+0x180
> 	0xa000000100011be0 ia64_ret_from_syscall
> 
> I see this same backtrace from numerous processes.

eh?  Why is dput freeing the dentry?  It should just be leaving it in cache.

What filesystem is being used?  procfs?
