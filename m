Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVECDUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVECDUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVECDUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:20:39 -0400
Received: from 70-57-132-14.albq.qwest.net ([70.57.132.14]:28816 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261335AbVECDUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:20:32 -0400
Date: Mon, 2 May 2005 21:21:50 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] xprt.c use after free of work_structs
In-Reply-To: <1115065314.11854.27.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0505022120280.12903@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0504302142460.9467@montezuma.fsmlabs.com>
 <1115065314.11854.27.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005, Trond Myklebust wrote:

> su den 01.05.2005 Klokka 00:02 (-0600) skreiv Zwane Mwaikambo:
> > This bug was first observed in 2.6.11-rc1-mm2 but i couldn't find the 
> > exact patch which would unmask it. The work_structs embedded in rpc_xprt 
> > are freed in xprt_destroy without waiting for all scheduled work to be 
> > completed, resulting in quite a kerfuffle. Since xprt->timer callback can 
> > schedule new work, flush the workqueue after killing the timer.
> 
> Hi Zwane,
> 
>   Thanks, I fully agree that this is needed.
> 
>  Chuck proposed a similar patch to me a couple of days ago, however he
> also pointed out that we need to call cancel_delayed_work() on
> xprt->sock_connect in the same code section in order to avoid trouble
> with the TCP reconnect code causing the same type of race. I've attached
> his mail.

Yes i wasn't sure i had caught all the cases.

Takk!
	Zwane
