Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUAPOHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUAPOHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:07:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265526AbUAPOHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:07:35 -0500
Date: Fri, 16 Jan 2004 14:07:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116140728.B24102@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	kgdb-bugreport@lists.sourceforge.net,
	kernel list <linux-kernel@vger.kernel.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116125806.GA7409@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040116125806.GA7409@elf.ucw.cz>; from pavel@ucw.cz on Fri, Jan 16, 2004 at 01:58:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:58:06PM +0100, Pavel Machek wrote:
> ++int kgdbeth_thread(void *data)
> ++{
> ++      struct net_device *ndev = (struct net_device *)data;
> ++      daemonize("kgdbeth");
> ++      while (!ndev->ip_ptr) {
> ++              schedule();
> ++      }
> ++      debugger_entry();
> ++      return 0;
> 
> Don't you need some locking around ndev->ip_ptr? [Okay, it probably
> only matters on SMP, so it is not causing your problems..]

Not to mention it should use a proper wait_event instead of this
really stupid loop.

