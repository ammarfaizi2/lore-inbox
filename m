Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUATEib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUATEib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:38:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:25246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbUATEia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:38:30 -0500
Date: Mon, 19 Jan 2004 20:38:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: markw@osdl.org
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: DBT-2 anticipatory scheduler and filesystem results with 2.6.1
Message-Id: <20040119203845.332cd5df.akpm@osdl.org>
In-Reply-To: <200401200005.i0K05do05666@mail.osdl.org>
References: <200401200005.i0K05do05666@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
>
>  I ran some dbt-2 tests against 5 filesystems with 2.6.1-mm4 and 2.6.1. I
>  see a degradation from 0 to 7% in throughput. 

-mm4 also had readahead changes which will adversely impact database-style
workloads.  I'd suggest that you revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/readahead-revert-lazy-readahead.patch

and retest.

We reverted lazy readahead because it broke NFS linear reads and was doing
the wrong thing anyway.  We need to come up with something else for
database-style workloads.

