Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269318AbUJKWvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbUJKWvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUJKWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:51:13 -0400
Received: from dyn3.mc.tuwien.ac.at ([128.130.175.85]:644 "EHLO
	mail.13thfloor.at") by vger.kernel.org with ESMTP id S269318AbUJKWvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:51:10 -0400
Date: Tue, 12 Oct 2004 00:57:01 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: lock issues
Message-ID: <20041011225700.GD32228@DUMA.13thfloor.at>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Trond!

experiencing the following panic on a linux-vserver
kernel (2.6.9-rc4, no modifications to locking)

Kernel panic - not syncing: Attempting to free lock with active block list

it's not easy to trigger but it happens now and then.
after adding a dump_stack() in panic() this is the trace

[<8011b945>] panic+0x55/0xe0		       
[<80174897>] fcntl_setlk64+0x137/0x2d0         
[<80119540>] autoremove_wake_function+0x0/0x60 
[<80179aba>] dnotify_parent+0x3a/0xb0	       
[<8015dc49>] fget+0x49/0x60		       
[<8016fa5b>] sys_fcntl64+0x4b/0xa0	       
[<8010426f>] syscall_call+0x7/0xb

it's the locks_free_lock(file_lock); at the end of 
fcntl_setlk64() and I'm asking myself if something
like in sys_flock()

        if (list_empty(&lock->fl_link)) {
                locks_free_lock(lock);
        }

would help here or just paper over the real issue?

TIA,
Herbert

