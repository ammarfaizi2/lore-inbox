Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUAQSwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbUAQSwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:52:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:13720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266099AbUAQSwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:52:16 -0500
Date: Sat, 17 Jan 2004 10:52:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: tmolina@cablespeed.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: 2.6.1-mm4
Message-Id: <20040117105239.0b94f2b3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401171805120.10403-100000@localhost.localdomain>
References: <Pine.LNX.4.58.0401170708280.14572@localhost.localdomain>
	<Pine.LNX.4.44.0401171805120.10403-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  > Code: 0a 3c c0 89 10 83 0d 20 0a 3c c0 20 a3 00 0a 3c c0 b8 00 e0 ff ff 21 
>  > e0 f7 40 14 00 ff ff 00 75 15 8b 15 40 0b 3c c0 85 d2 74 0b <8b> 02 85 c0 
>  > 75 0a 90 8d 74 26 00 53 9d 5b 5d c3 89 d0 e8 b4 1a
>  > <6>note: S01reboot[2352] exited with preempt_count 1
> 
>  I was getting something like that on reboot a few days ago, I think it
>  was with 2.6.1-mm2.  I had to move on before debugging it fully, but
>  the impression I got (maybe vile calumny, sue me Rusty) was that the
>  new kthread_create for 2.6.1-mm's ksoftirqd was leaving it vulnerable
>  to shutdown kill, whereas other things (RCU in my traces) still needed
>  it around and assumed its task address still valid.

Yes.  ksoftirqd and the migration threads can now be killed off
with `kill -9'.
