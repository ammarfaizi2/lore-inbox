Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWEYEkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWEYEkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEYEkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:40:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965014AbWEYEkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:40:24 -0400
Date: Wed, 24 May 2006 21:39:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM'ing with 2GB of ram and no "large" memory processes.
Message-Id: <20060524213956.5ab06bb4.akpm@osdl.org>
In-Reply-To: <447519BE.9090103@comcast.net>
References: <447519BE.9090103@comcast.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <safemode@comcast.net> wrote:
>
> This was trigged when concurrently encoding multiple gigabytes of video 
> with mencoder. Mencoder doesn't appear to be leaking any memory however, 
> and in fact only seems to be using 20MB each.  I have 2GB of ram and 
> apparently as far as "free" is concerned, 1.67GB of it is in cache.  My 
> largest memory hogging process is X with 85MB resident, firefox then 
> thunderbird following.  I dont run swap.  I'm not sure why OOM was 
> triggered and why it apparently wanted to kill some daemons and firefox 
> (even though both were still running afterwards).  If anyone can tell me 
> why, that would be greatly appreciated.   Here is what dmesg gave me.
> 
> ...
> 
> DMA32 free:7960kB min:5708kB low:7132kB high:8560kB active:1983536kB 
> inactive:276kB present:2052260kB pages_scanned:299393 all_unreclaimable? no

Something has caused basically all the pages to get stuck on the active
list.  My grepping of the mencoder source turns up no mlock()s, so it's not
that.

Have you been playing with /proc/sys/vm/swappiness?

What's in /proc/meminfo when this is all happening?
