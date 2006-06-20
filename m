Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWFTIEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWFTIEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFTIEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:04:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964992AbWFTIEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:04:14 -0400
Date: Tue, 20 Jun 2006 01:03:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: olson@unixfolk.com, mingo@elte.hu, ccb@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
Message-Id: <20060620010355.a4d1348a.akpm@osdl.org>
In-Reply-To: <4497A5BC.4070005@yahoo.com.au>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
	<fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
	<Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
	<20060619233947.94f7e644.akpm@osdl.org>
	<4497A5BC.4070005@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 17:37:32 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>Kernel panic - not syncing: nmi watchdog 
> 
> Any ideas what it might be waiting on?

Readers, I guess.  When there's a spinning writer, nothing prevents _new_
readers from getting into the read-locked region.  If we have enough
readers and the read-locked region is long enough, there's always at least
one reader in the read-locked region and the writer is permanently starved.

> Otherwise, a straight rwlock->spinlock conversion will have a few more
> scalability issues, but I'd guess it wouldn't be a problem  at all for
> most workloads on most systems.

It beats crashing.
