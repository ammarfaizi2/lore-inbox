Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUAAKZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAAKZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:25:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:60550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265378AbUAAKZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:25:21 -0500
Date: Thu, 1 Jan 2004 02:25:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: joneskoo@derbian.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-Id: <20040101022553.2be5f043.akpm@osdl.org>
In-Reply-To: <20040101101541.GJ28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
	<20040101101541.GJ28023@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> > swapper: page allocation failure. order:3, mode:0x20
> 
> ...
>  We should probably rate limit that printk. Andrew: I was thinking of
>  stealing net_ratelimit and calling it core_ratelimit or whatever. Then
>  wrap these non critical things with it. Overkill?

Actually my intent was just to remove it (and __GFP_NOWARN) - it's just
development-time debug.  But it is handy on occasion.

So sure, ratelimit it, make it KERN_INFO and maybe add a dump_stack()?

(printk_ratelimit() may be a suitable name)
