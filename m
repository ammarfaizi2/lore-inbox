Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUEPJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUEPJgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUEPJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 05:36:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:19117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263435AbUEPJgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 05:36:39 -0400
Date: Sun, 16 May 2004 02:36:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Faik Uygur <faikuygur@tnn.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use idr_get_new to allocate a bus id in
 drivers/i2c/i2c-core.c
Message-Id: <20040516023605.5031a238.akpm@osdl.org>
In-Reply-To: <20040516091312.GA2052@tnn.net>
References: <20040515222632.GA7218@dsl.ttnet.net.tr>
	<20040515165812.7e771f20.akpm@osdl.org>
	<20040516091312.GA2052@tnn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faik Uygur <faikuygur@tnn.net> wrote:
>
>  > Is the kernel likely to ever have so many bus IDs that we actually need
>  > this patch?  Or do you specifically want first-fit-from-zero for some
>  > reason?
> 
>  Actually there is no special need for this. It is just what i think would
>  be the expected behaviour. There was a thread two weeks ago about this issue:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=108370586601550&w=2
> 
>  here is the updated patch:

Looks good to me, thanks.

fyi, the IDR implementation in -mm doesn't mangle the top eight bits of the
idr_get_new() return value, so that masking will be able to go away.

And you'll then be able to support 2^31-1 i2c adapters...
