Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTAEASB>; Sat, 4 Jan 2003 19:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTAEASB>; Sat, 4 Jan 2003 19:18:01 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:58514 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261908AbTAEAR7>; Sat, 4 Jan 2003 19:17:59 -0500
Cc: linux-kernel@vger.kernel.org
References: <20030104160255.6187.qmail@webmail28.rediffmail.com>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: "anil  vijarnia" <linux_ker@rediffmail.com>
Subject: Re: writing from kernel
Date: Sun, 05 Jan 2003 01:26:19 +0100
Message-ID: <87d6nccuhg.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"anil  vijarnia" <linux_ker@rediffmail.com> writes:

> can anyone tell me how to write into i file from kernel space.
> i tried sys_open,sys_write functions bbbbbut they don't work
>  from
> my module.

As others already pointed out, it's not always a good idea to do this
from kernel space. However, if you still want to do it, see snippet
below. If you want to write, you have to copy kernel_read() from
fs/exec.c and modify it for writing.

Regards, Olaf.

--cut here-->8--
#include <linux/fs.h>

struct file *filp;
unsigned long offset = 0;
char buf[1024];
int n;

filp = filp_open("/path/to/some/file", O_RDONLY, 0);
if (!filp || IS_ERR(filp)) {
   /* do some error handling */
}

n = kernel_read(filp, offset, buf, sizeof(buf));
if (n != sizeof(buf)) {
   /* do some checking */
}

filp_close(filp, 0);
--8<--cut here--
