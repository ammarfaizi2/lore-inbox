Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCQWIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCQWIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCQWIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:08:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:50079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261257AbVCQWI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:08:28 -0500
Date: Thu, 17 Mar 2005 14:08:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-Id: <20050317140831.414b73bb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
> /proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
> scrubd.txt

It's hard to know what to think about this without benchmarking numbers.

It would help if you could briefly describe the implementation and design
decisions when sending patches.

For example, one area where we could use this is in pagetable management,
where we need zeroed pages and we tend to free up known-to-be-zero and
probably cache-warm pages.  Right now some architectures are maintaining
their own quicklists, or using a slab cache, both of which are suboptimal.

But afaict the patch doesn't differentiate between cache-cold and cache-hot
zeroed pages, and doesn't have an API with which clients can free up a
known-to-be-zero page.

