Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUAPO04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUAPO0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:26:55 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:9620 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265548AbUAPOZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:25:31 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 19:54:54 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116125806.GA7409@elf.ucw.cz> <20040116140728.B24102@infradead.org>
In-Reply-To: <20040116140728.B24102@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401161954.54612.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 7:37 pm, Christoph Hellwig wrote:
> On Fri, Jan 16, 2004 at 01:58:06PM +0100, Pavel Machek wrote:
> > ++int kgdbeth_thread(void *data)
> > ++{
> > ++      struct net_device *ndev = (struct net_device *)data;
> > ++      daemonize("kgdbeth");
> > ++      while (!ndev->ip_ptr) {
> > ++              schedule();
> > ++      }
> > ++      debugger_entry();
> > ++      return 0;
> >
> > Don't you need some locking around ndev->ip_ptr? [Okay, it probably
> > only matters on SMP, so it is not causing your problems..]
>
> Not to mention it should use a proper wait_event instead of this
> really stupid loop.

Yep. Will do that. This is just first version to get some thing going.

Things that'll have to be fixed before this is usable as a debugger.
1. Change skbuff handling to use kgdb-specific buffers when 
kgdb_handle_exception begins.
2. Get rid of this way of bringing up ethernet interface.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

