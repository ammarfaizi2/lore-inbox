Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUIAXkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUIAXkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUIAXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:39:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:53739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268170AbUIAXYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:24:36 -0400
Date: Wed, 1 Sep 2004 16:27:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: jakub@redhat.com, ak@suse.de, ecd@skynet.be, pavel@suse.cz,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/compat.c: rwsem instead of BKL around
 ioctl32_hash_table
Message-Id: <20040901162756.36c10fac.akpm@osdl.org>
In-Reply-To: <524qmi2e1s.fsf@topspin.com>
References: <20040901072245.GF13749@mellanox.co.il>
	<524qmi2e1s.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
> Currently the BKL is used to synchronize access to ioctl32_hash_table
> in fs/compat.c.  It seems that an rwsem would be more appropriate,
> since this would allow multiple lookups to occur in parallel (and also
> serve the general good of minimizing use of the BKL).

It introduces additional bus-atomic operations into the fastpath, so we'll
be slower in the one-process-doing-lots-of ioctls case, and faster in the
lots-of-cpus-doing-ioctls case.

The change certainly makes sense from a clean-things-up and
prepare-for-bkl-removal point of view, however.

Some single-threaded and multi-threaded SMP microbenchmarking would be
nice, if you have time.
