Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWIHA67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWIHA67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWIHA67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:58:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751991AbWIHA66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:58:58 -0400
Date: Thu, 7 Sep 2006 17:58:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Avoiding fragmentation with subzone groupings v25
Message-Id: <20060907175848.63379fe1.akpm@osdl.org>
In-Reply-To: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Sep 2006 20:03:42 +0100 (IST)
Mel Gorman <mel@csn.ul.ie> wrote:

> When a page is allocated, the page-flags
> are updated with a value indicating it's type of reclaimability so that it
> is placed on the correct list on free.

We're getting awful tight on page-flags.

Would it be possible to avoid adding the flag?  Say, have a per-zone bitmap
of size (zone->present_pages/(1<<MAX_ORDER)) bits, then do a lookup in
there to work out whether a particular page is within a MAX_ORDER clump of
easy-reclaimable pages?
