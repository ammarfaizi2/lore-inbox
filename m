Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWF1Sle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWF1Sle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWF1Sle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:41:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:56376 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750942AbWF1Sld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:41:33 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="61008003:sNHT29366616"
Date: Wed, 28 Jun 2006 19:41:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
In-Reply-To: <20060627054612.GA15657@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
 <20060627054612.GA15657@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jun 2006 18:41:33.0293 (UTC) FILETIME=[7A5E61D0:01C69AE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006, Serge E. Hallyn wrote:
> 
> Very sorry.

No problem, just something I happened to notice, that's all.

> Subject: [PATCH] kthread: convert loop.c to use kthread
> 
> Convert loop.c to use kthread in place of the deprecated
> kernel_thread.
> 
> Update: Keep the lo_done completion to indicate when the
> 	loop_thread is ready.  Otherwise a user gets the
> 	go-ahead early and may start an ioctl before
> 	loop_thread is in fact ready.
> 
> 	Also fix some other bugs including misnaming the thread,
> 	found by Andrew Morton, and not setting lo->thread as
> 	pointed out by Hugh Dickins.
> 
> 	This version has passed parallel runs of the following
> 	script (on different devices of course), i.e.

But not good for me.  Gets further e.g. 170 iterations,
but then hangs while kthread_stop waits for completion.

I haven't investigated further.  Is there really any reason
to be messing with what has worked well for so long here?

Hugh
