Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVAXVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVAXVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVAXVC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:02:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:15768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261661AbVAXU5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:57:30 -0500
Date: Mon, 24 Jan 2005 12:56:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050124125649.35f3dafd.akpm@osdl.org>
In-Reply-To: <20050124204659.GB19242@suse.de>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<1106528219.867.22.camel@boxen>
	<20050124204659.GB19242@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  Here is the output of your program (somewhat modified, I cut the runtime
>  by 19/20 killing the 1-byte reads :-) after 10 hours of use with
>  bk-current as of this morning.

hmm..

62130 times: Page allocated via order 0
[0xffffffff80173d6e] pipe_writev+574
[0xffffffff8017402a] pipe_write+26
[0xffffffff80168b47] vfs_write+199
[0xffffffff80168cb3] sys_write+83
[0xffffffff8011e4f3] cstar_do_call+27

55552 times: Page allocated via order 0
[0xffffffff80173d6e] pipe_writev+574
[0xffffffff8017402a] pipe_write+26
[0xffffffff8038b88d] thread_return+41
[0xffffffff80168b47] vfs_write+199
[0xffffffff80168cb3] sys_write+83
[0xffffffff8011e4f3] cstar_do_call+27

Would indicate that the new pipe code is leaking.
