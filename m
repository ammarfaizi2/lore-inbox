Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDNKLz (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTDNKLz (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:11:55 -0400
Received: from [12.47.58.203] ([12.47.58.203]:24438 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262932AbTDNKLy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 06:11:54 -0400
Date: Mon, 14 Apr 2003 03:23:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre7 ide request races
Message-Id: <20030414032339.27079dd8.akpm@digeo.com>
In-Reply-To: <20030414101747.GR9776@suse.de>
References: <20030414093418.GQ9776@suse.de>
	<20030414030751.7bf17b04.akpm@digeo.com>
	<20030414101747.GR9776@suse.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 10:23:38.0319 (UTC) FILETIME=[E9C5DDF0:01C3026F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> How would that solve the problem? The request could be gone even before
> end_that_request_last() is run, that is the issue.

In that case I didn't understand your description of the bug even the tiniest
little bit.

That request is sitting in the kernel stack of some process which is sleeping
in wait_for_completion().  Hence it is safe memory until someone runs
complete() against the completion struct.
