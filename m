Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUCKXXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCKXXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:23:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:40935 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261824AbUCKXXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:23:54 -0500
Date: Thu, 11 Mar 2004 15:25:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, piggin@cyberone.com.au
Subject: Re: blk_congestion_wait racy?
Message-Id: <20040311152552.20a9bb06.akpm@osdl.org>
In-Reply-To: <OFF79FE9F7.73A1504E-ONC1256E54.006825BF-C1256E54.0068C4F9@de.ibm.com>
References: <OFF79FE9F7.73A1504E-ONC1256E54.006825BF-C1256E54.0068C4F9@de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> > An ouch-per-second sounds reasonable.  It could simply be that the CPUs
> > were off running other tasks - those timeout are less than scheduling
> > quanta.
> 
> I don't understand why an ouch-per-second is reasonable. The mempig is
> the only process that runs on the machine and the blk_congestion_wait
> uses HZ/10 as timeout value. I'd expect about 100 ouches for the 10
> seconds the test runs.

blk_congestion_wait() is supposed to be terminated by someone releasing a
disk write request.  If no write requests are freed in 100 milliseconds
then either Something Is Up or that process simply was not scheduled for
some time after the wakeup was delivered.


