Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTKYPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTKYPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:22:59 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:46684 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262731AbTKYPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:22:58 -0500
Message-ID: <3FC348D1.8060408@yahoo.com>
Date: Tue, 25 Nov 2003 07:19:29 -0500
From: moiz kohari <moiz_kohari@yahoo.com>
Reply-To: moiz_kohari@yahoo.com
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Posix record locking.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking at posix record locking with nfs and I have a couple of 
questions:

1. The fcntl_setlk() calls nfs_lock() (towards the end of fcntl_setlk by 
calling filp->f_op->lock), fcntl_setlk() then calls posix_lock_file() 
(where all the vfs magic happens for file locks).  If nfs_lock() returns 
successful (server has granted the lock) but the subsequent 
posix_lock_file() fails (due to deadlock, conflict or low memory), we 
never go back to the server to clean up this lock.  Is this a problem or 
am I missing something?

2. nfs_lock() calls nlmclnt_proc() after we pick up the kernel lock 
(lock_kernel()).  The nlmclnt_proc() goes on to call:
   nlmclnt_lock()
   nlmclnt_call()
   rpc...

Is this OK?  Are we going over the wire while holding the kernel lock?

Best Regards,

Moiz


