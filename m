Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWBFUMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWBFUMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWBFUMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:12:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932365AbWBFUL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:11:59 -0500
Date: Mon, 6 Feb 2006 12:11:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060206121133.4ef589af.akpm@osdl.org>
In-Reply-To: <43E75FB6.2040203@rtr.ca>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<43E75ED4.809@rtr.ca>
	<43E75FB6.2040203@rtr.ca>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> wrote:
>
> A simple test I do for this:
> 
>  $ mkdir t
>  $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
> 
>  In another window, I do this:
> 
>  $ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done
> 
>  And then watch the count get large, but take virtually forever
>  to count back down to a "safe" value.
> 
>  Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
>  as expected.

I've never seen that happen and I don't recall seeing any other reports of
it, so your machine must be doing something peculiar.  I think it can
happen if, say, an inode gets itself onto the wrong inode list, or
incorrectly gets its dirty flag cleared.

Are you using any unusual mount options, or unusual combinations of
filesystems, or anything like that?

