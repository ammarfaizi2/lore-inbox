Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUI0Ttq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUI0Ttq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUI0Ttq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:49:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43729 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267285AbUI0Tto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:49:44 -0400
Date: Mon, 27 Sep 2004 12:48:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040927124836.2983ff9b.pj@sgi.com>
In-Reply-To: <1096305177.30503.65.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	<1096305177.30503.65.camel@betsy.boston.ximian.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];

This assumes that MAX_INOTIFY_DEV_WATCHERS is an integral multiple
of BITS_PER_LONG, otherwise, the last word will be missing.

Perhaps this would this better be written as:

	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);

and the clearing of it in the original patch:

> +	memset(dev->bitmask, 0,
> +	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);

might better be written as:

	CLEAR_BITMAP(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
