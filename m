Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVGEWMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVGEWMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVGEWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:09:00 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48745 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261963AbVGEWHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:07:44 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
X-Message-Flag: Warning: May contain useful information
References: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
	<2005628163.gtJFW6uLUrGQteys@cisco.com>
	<20050628170553.00a14a29.akpm@osdl.org> <52mzp1oy91.fsf@topspin.com>
	<20050705205351.GB28064@mellanox.co.il>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 05 Jul 2005 15:07:28 -0700
In-Reply-To: <20050705205351.GB28064@mellanox.co.il> (Michael S. Tsirkin's
 message of "Tue, 5 Jul 2005 23:53:51 +0300")
Message-ID: <52d5pwnbz3.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Jul 2005 22:07:40.0386 (UTC) FILETIME=[F5D88420:01C581AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Roland, I think VM_DONTCOPY is needed here.

    Michael> If a process forks, we must prevent the child from
    Michael> accessing the parent's hardware page. Otherwise the child
    Michael> can corrupt the parent's queues since the hardware wont
    Michael> be able to distinguish between parent and child.

    Michael> Does this make sense?

This is true, but there are a number of pieces that are required
before fork will work for processes using userspace verbs.  One of the
ingredients that's missing is adding something like PROT_DONTCOPY for
mprotect().  Once that's in place, an app can use that on the
doorbell page before forking.

I don't consider this attack by children of a process very serious,
since a process can always fork, munmap the doorbell page in the child
process, and then fork the untrusted child into yet another child.

 - R.
