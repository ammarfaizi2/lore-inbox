Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUDMDmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 23:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUDMDmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 23:42:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:27102 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263169AbUDMDml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 23:42:41 -0400
Date: Mon, 12 Apr 2004 20:42:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [PATCH] eliminate nswap and cnswap
Message-Id: <20040412204223.2a07d123.akpm@osdl.org>
In-Reply-To: <1081827102.1593.227.camel@cube>
References: <1081827102.1593.227.camel@cube>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> > The nswap and cnswap variables counters have never
> > been incremented as Linux doesn't do task swapping.
> 
> I'm pretty sure they were used for paging activity.
> We don't eliminate support for "swap space", do we?
> 
> Somebody must have broken nswap and cnswap while
> hacking on some vm code. I hate to see the variables
> get completely ripped out of the kernel instead of
> getting fixed.

There's nothing in 2.4 which increments these, nor was there in 2.6.  Which
tends to imply that they weren't very important.

We could sort-of do this - move them into mm_struct (doing it in
task_struct was always wrong) and increment them in the VM.  But we'd need
some reason why these statistics are interesting, and we'd need an
explanation of what nswap and cnswap are actually supposed to represent.  

