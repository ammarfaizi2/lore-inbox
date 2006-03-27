Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWC0VU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWC0VU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWC0VU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:20:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751444AbWC0VU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:20:26 -0500
Date: Mon, 27 Mar 2006 13:10:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: sho@tnes.nec.co.jp, kiran@scalex86.org, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       Laurent.Vivier@bull.net
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-Id: <20060327131049.2c6a5413.akpm@osdl.org>
In-Reply-To: <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	<1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I am wondering if we have (or plan to have) "long long " type of percpu
>  counters?  Andrew, Kiran, do you know?  
> 
>  It seems right now the percpu counters are used mostly by ext2/3 for
>  filesystem free blocks accounting. Right now the counter is "long" type,
>  which is not enough if we want to extend the filesystem limit from 2**31
>  to 2**32 on 32 bit machine.
> 
>  The patch from Takashi copies the whole percpu_count.h  and create a new
>  percpu_llcounter.h to support longlong type percpu counters. I am
>  wondering is there any better way for this?
> 

I can't immediately think of anything smarter.

One could of course implement a 64-bit percpu counter by simply
concatenating two 32-bit counters.  That would be a little less efficient,
but would introduce less source code and would mean that we don't need to
keep two different implemetations in sync.  But one would need to do a bit
of implementation, see how bad it looks.
