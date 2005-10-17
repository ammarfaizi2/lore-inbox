Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVJQTZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVJQTZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVJQTZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:25:26 -0400
Received: from fmr22.intel.com ([143.183.121.14]:48302 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751044AbVJQTZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:25:25 -0400
Message-Id: <200510171925.j9HJPKg12681@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] indirect function calls elimination in IO scheduler
Date: Mon, 17 Oct 2005 12:25:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXTRceZS1qYV3apR4GZv5R3gHJ5EQAB/1tg
In-Reply-To: <20051017175858.GY2811@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Monday, October 17, 2005 10:59 AM
> you cannot ref count a statically embedded structure. It has to be
> dynamically allocated.

I'm confused.  For every block device queue, there is one unique
elevator_t structure allocated via kmalloc.  And vice versa, one
elevator_t has only one request_queue points to it. This elevator_t
structure is per q since it has pointer to per-queue elevator
private data.

Since it is always one to one relationship, ref count is predictable
and static.  I see there are ref count on q->elevator, But it is
always 2: one from object instantiation and one from adding an sysfs
hierarchy directory.  In this case, I don't see the difference.
Am I missing something?

- Ken

