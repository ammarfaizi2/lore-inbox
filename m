Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUBVT4y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUBVTz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:55:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:52133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261738AbUBVTzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:55:19 -0500
Date: Sun, 22 Feb 2004 11:55:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.net>
Cc: axboe@suse.de, thornber@redhat.com, miquels@cistron.net,
       piggin@cyberone.com.au, miquels@cistron.nl, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process
 request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-Id: <20040222115504.001384d1.akpm@osdl.org>
In-Reply-To: <20040222140232.GE1375@drinkel.cistron.nl>
References: <20040219205907.GE32263@drinkel.cistron.nl>
	<40353E30.6000105@cyberone.com.au>
	<20040219235303.GI32263@drinkel.cistron.nl>
	<40355F03.9030207@cyberone.com.au>
	<20040219172656.77c887cf.akpm@osdl.org>
	<40356599.3080001@cyberone.com.au>
	<20040219183218.2b3c4706.akpm@osdl.org>
	<20040220144042.GC20917@traveler.cistron.net>
	<20040220145944.GM27549@reti>
	<20040220150013.GY27190@suse.de>
	<20040222140232.GE1375@drinkel.cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.net> wrote:
>
> The pdflush-is-running-on-this-queue bit can probably remain as-is. It's
>  mostly meant to prevent 2 pdflush daemons from running the same queue.
>  I don't see much harm in pdflush #1 running on /dev/md0 which consists
>  of /dev/sda1 and /dev/sdb1 and pdflush #2 running on /dev/sdb2, right ?

Yes, having two pdflushes working the same spindle is a bit pointless but
is presumably fairly harmless.

The most important thing here is to prevent pdflush from blocking on
request exhaustion.  Because while pdflush sleeps on a particular disk, all
the others remain unserviced.

