Return-Path: <linux-kernel-owner+w=401wt.eu-S1751018AbXAHV1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXAHV1g (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXAHV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:27:36 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:24531 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbXAHV1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:27:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZW2FL0cza0y8nXV3OyYvogWDTH/uuclxCd5OX8GXugLHqTiWOGLpPrBr9iA7BN7InXNEw/sg311eD4kY6+mLT+iaL8YipXCBtIJiXogvyRdu0vZpN5Qyoz73ZW0kvJ2luHNS/AV4DvT3CbO++zzVsdi1vv0PjF6TlDzqncISXEU=
Message-ID: <1458d9610701081327sb9de173qc5b7d99558ed22ae@mail.gmail.com>
Date: Mon, 8 Jan 2007 16:27:32 -0500
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [BUG] sleeping function called from invalid context at kernel/sched.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to do file write operations in a thread (filewrite())
initiated from a jprobe (fs_vfs_write()) set on kernel function
(vfs_write()). Although the write operation succeed, I get this on my
log:

BUG: sleeping function called from invalid context at kernel/sched.c:3678
in_atomic():0, irqs_disabled():1
 [<c011a65b>] __might_sleep+0xa5/0xab
 [<c0343a00>] wait_for_completion+0x1a/0xc9
 [<c0118480>] __wake_up+0x32/0x43
 [<c012b33a>] __queue_work+0x42/0x4f
 [<c012e0f7>] kthread_create+0x9b/0xd3
 [<c012e00a>] keventd_create_kthread+0x0/0x52
 [<f8a560d4>] filewrite+0x0/0xaf [fsTrace]
 [<c03464b9>] do_page_fault+0x31f/0x5c5
 [<f8a561da>] fs_vfs_write+0x57/0x9e [fsTrace]
 [<f8a560d4>] filewrite+0x0/0xaf [fsTrace]
 [<c015f396>] sys_write+0x41/0x67
 [<c01034d1>] sysenter_past_esp+0x56/0x79
 =======================

$ uname -a
Linux cluster3 2.6.19.1 #1 SMP Thu Dec 21 14:03:57 EST 2006 i686
athlon i386 GNU/Linux

I remember seeing something similar here on LKML, but am unable to
trace it right now. Any idea what's going wrong?

Thanks,
Sumit
