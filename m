Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbTCGHjC>; Fri, 7 Mar 2003 02:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbTCGHjC>; Fri, 7 Mar 2003 02:39:02 -0500
Received: from ip-33-237-104-152.anlai.com ([152.104.237.33]:35591 "EHLO
	exchsh01.viatech.com.cn") by vger.kernel.org with ESMTP
	id <S261430AbTCGHjB>; Fri, 7 Mar 2003 02:39:01 -0500
Message-ID: <C373923C3B6ED611874200010250D52E155E23@exchsh01.viatech.com.cn>
From: "Guangyu Kang (Shanghai)" <GuangyuKang@viatech.com.cn>
To: "'Elladan'" <elladan@eskimo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Help please: DVD ROM read difficulty
Date: Fri, 7 Mar 2003 15:49:27 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="GB2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan, thank you for your reply :)

>I've had to try junk like:
>
>	while true ; do kill -9 $stupid_process ; done
>
>.. just to get something to die when it's reading bad media.
>A quick way around this tends to be to hit the eject button on the CD
>drive itself - it will cause the driver to abort the read quickly when
>it sees that the drive is empty.

You are quite right, this is exactly what I got. Maybe the cache mechanism
will do some check
before send request to the ide-cd driver, and it will abort at that point,
since there is an path
for the failure report.

While to me, this issue is some how player quality related, I have to deal
with it. And you said that
the error handling is not good at all, I think its hopeless for me to hack
into fs and cache. Now I have
an idea in mind to implement an ioctl() set to do this.
Looks like:
CDROM_IOCTL_LOCK
CDROM_IOCTRL_REALTIME_LOGICBLOCK_READ
The lock will make the driver refuse any more open to the driver, thus the
driver can concdern on read
operation from my ioctl while not the reauest. If some one opened the driver
already, lock will fail.
The read will be an re-organize of request handler code, adding more
straight-forward error handling,
which will get data from drive and copy it to user. Without the cache layer,
in player case,
better performance may be the additional gain.

Ugly though, this should be some how easier.

Any comment and advice is welcomed!
