Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbUKYAUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUKYAUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUKYASR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:18:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:15059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262943AbUKYAQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:16:24 -0500
Date: Wed, 24 Nov 2004 15:50:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: phil@dier.us, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124155038.3716b8a5.akpm@osdl.org>
In-Reply-To: <16805.5470.892995.589150@cse.unsw.edu.au>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<16805.5470.892995.589150@cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> Would the following (untested-but-seems-to-compile -
> explanation-of-concept) patch be at all reasonable to avoid stack
> depth problems with stacked block devices, or is adding stuff to
> task_struct frowned upon? 

It's always a tradeoff - we've put things in task_struct before to get
around sticky situations.  Certainly, removing potentially unbounded stack
utilisation is a worthwhile thing to do.

The patch bends my brain a bit.  Shouldn't the queueing happen in
submit_bio()?

Is bi_next free in there?  If anyone tries to do synchronous I/O things
will get stuck.

