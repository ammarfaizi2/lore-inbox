Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVIJFmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVIJFmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVIJFmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:42:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932612AbVIJFmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:42:53 -0400
Date: Fri, 9 Sep 2005 22:41:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: awesley@acquerra.com.au
Cc: nate.diller@gmail.com, rheflin@atipa.com, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
Message-Id: <20050909224148.3bf40856.akpm@osdl.org>
In-Reply-To: <43222DC3.9080609@acquerra.com.au>
References: <432151B0.7030603@acquerra.com.au>
	<EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
	<5c49b0ed05090914394dba42bf@mail.gmail.com>
	<43222DC3.9080609@acquerra.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Wesley <awesley@acquerra.com.au> wrote:
>
>  How else can it take only 70 seconds to reach 95% dirty when I have 1.3Gb of available RAM and data coming in at 25MBytes/sec and out at 17MBytes/sec? It doesn't make any sense...

What architecture?   x86?

If so then bear in mind that your memory is split into 500MB highmem and
800MB lowmem.  The kernel might be starting I/O due to the highmem zone
being full of dirty pages.  That'd be wrong of it if so - it's supposed to
just fall back to lowmem for the page allocations, but that code has
changed quite a bit in the two years since I got all that working...

You need to run `watch -n1 cat /proc/meminfo' while doing these tests...
