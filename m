Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTKZXBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTKZXBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:01:49 -0500
Received: from ns.suse.de ([195.135.220.2]:18135 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264364AbTKZXBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:01:48 -0500
Date: Thu, 27 Nov 2003 00:01:45 +0100
From: Andi Kleen <ak@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031127000145.61187530.ak@suse.de>
In-Reply-To: <shsllq3yy2u.fsf@charged.uio.no>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<shsllq3yy2u.fsf@charged.uio.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2003 10:00:09 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> >>>>> " " == Andi Kleen <ak@suse.de> writes:
> 
>      > - If they tested TCP-over-NFS then I'm pretty sure Linux lost
>                         ^^^^^^^^^^^^ That would be inefficient 8-)

grin. 

>      > badly because the current paths for that are just awfully
>      > inefficient.
> 
> ...mind elaborating?

Current sunrpc does two recvmsgs for each record to first get the record length 
and then the payload.

This means you take all the locks and other overhead twice per packet. 

Having a special function that peeks directly at the TCP receive
queue would be much faster (and falls back to normal recvmsg when
there is no data waiting) 

But that's the really obvious case. I think if you got out an profiler
and optimized carefully you could likely make this path much more
efficient. Same for sunrpc TX probably, although that seems to be
in a better shape already.

-Andi 
