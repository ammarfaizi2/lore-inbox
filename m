Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUEYHri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUEYHri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbUEYHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:47:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:44252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261907AbUEYHrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:47:36 -0400
Date: Tue, 25 May 2004 00:46:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nathans@sgi.com, hch@infradead.org, herbert@gondor.apana.org.au,
       leo@bononia.it, 250477@bugs.debian.org, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#250477: kernel-source-2.4.26: Lots of debug in RAID5
Message-Id: <20040525004621.02d7ae42.akpm@osdl.org>
In-Reply-To: <16562.59365.755616.435629@cse.unsw.edu.au>
References: <20040523085801.2878013C002@nomade.ciram.unibo.it>
	<20040523105351.GB19402@gondor.apana.org.au>
	<20040523111622.GA24817@infradead.org>
	<20040524110059.B751892@wobbly.melbourne.sgi.com>
	<16562.59365.755616.435629@cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
>  +					static long recent;
>  +					static int cnt;
>  +					static int warned;
>  +					if (time_after(recent+HZ, jiffies))
>  +						cnt++;
>  +					else {
>  +						recent = jiffies;
>  +						cnt = 0;
>  +					}
>  +					if (cnt > 50 && ! warned) {
>  +						printk("raid5: WARNING:array used in unsupported configuration, expect poor performance\n");
>  +						warned = 1;
>  +					}
>  +					if (!warned)
>  +						printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);

Is it not possible to use __printk_ratelimit() in here?
