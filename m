Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUGMECi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUGMECi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUGMECi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:02:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:33169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263815AbUGMECZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:02:25 -0400
Date: Mon, 12 Jul 2004 21:01:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: devenyga@mcmaster.ca, ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: Preempt Threshold Measurements
Message-Id: <20040712210107.1945ac34.akpm@osdl.org>
In-Reply-To: <cone.1089687290.911943.12958.502@pc.kolivas.org>
References: <200407121943.25196.devenyga@mcmaster.ca>
	<20040713024051.GQ21066@holomorphy.com>
	<200407122248.50377.devenyga@mcmaster.ca>
	<cone.1089687290.911943.12958.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Gabriel Devenyi writes:
> 
> > Well I'm not particularly educated in kernel internals yet, here's some 
> > reports from the system when its running.
> > 
> > 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
> > at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
> 
> Certainly the do_munmap and exit_mmap seem to be repeat offenders on my 
> machine too (more the latter in my case).
> 

This is a false positive.  Nothing is setting need_resched(), so
unmap_vmas() doesn't bother dropping the lock.

