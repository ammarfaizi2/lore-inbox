Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVAFFhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVAFFhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVAFFhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:37:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:16816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262738AbVAFFhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:37:38 -0500
Date: Wed, 5 Jan 2005 21:37:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105213704.0282316f.akpm@osdl.org>
In-Reply-To: <20050106052507.GR4597@dualathlon.random>
References: <20050105173624.5c3189b9.akpm@osdl.org>
	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
	<41DCB577.9000205@yahoo.com.au>
	<20050105202611.65eb82cf.akpm@osdl.org>
	<41DCC014.80007@yahoo.com.au>
	<20050105204706.0781d672.akpm@osdl.org>
	<20050106045932.GN4597@dualathlon.random>
	<20050105210539.19807337.akpm@osdl.org>
	<20050106051707.GP4597@dualathlon.random>
	<41DCCA68.3020100@yahoo.com.au>
	<20050106052507.GR4597@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 2) we won't need unreliable anti-deadlock timeouts anymore

The timeouts are for:

a) A fallback for backing stores which don't wake up waiters in
   blk_congestion_wait() (eg: NFS).

b) handling the race case where the request queue suddenly goes empty
   before the sleeper gets onto the waitqueue.

It can probably be removed with some work, and additional locking.
