Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUKYBUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUKYBUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbUKYBSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:18:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:26773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262885AbUKYBQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:16:25 -0500
Date: Wed, 24 Nov 2004 17:05:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: phil@dier.us, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124170553.22e57225.akpm@osdl.org>
In-Reply-To: <16805.9199.955186.236115@cse.unsw.edu.au>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<16805.5470.892995.589150@cse.unsw.edu.au>
	<20041124155038.3716b8a5.akpm@osdl.org>
	<16805.9199.955186.236115@cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> If a ->make_request_fn did synchronous IO things would definitely get
>  unstuck.   But I don't think they should and doubt if they do (md
>  certainly doesn't).

generic_make_request() can block in get_request_wait(), but I can't
immediately think of a way in which that can deadlock things, especially if
each level is using a distinct queue.

It could certainly deadlock if a higher-level make_request() caller
required allocation of two or more requests at a lower level - all we'd
need is N/2 proceses each trying to allocate two requests.  But such a
lockup could happen in the current code anyway..  
