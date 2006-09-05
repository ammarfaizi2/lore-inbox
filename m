Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWIERhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWIERhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWIERhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:37:53 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:35042 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932202AbWIERhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:37:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nLtOPEr7i2yhdEGC5HWj7dTjYWIrUAE62UY0X50rA4Fd65nO95GLPjVKI0UbFeuYTRCGAQER2rmsVosUT3ntqphQbHrFW3VKGzA6tOKxkm/D2ztft2x3SioMteBlmL65KUYH6Q9HcJJRldWLbN6q2DZFtlQG35PBjqpgV3Mhimg=
Message-ID: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
Date: Tue, 5 Sep 2006 10:37:51 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]

=============================================
[ INFO: possible recursive locking detected ]
2.6.18-rc5-mm1 #2
---------------------------------------------
knodemgrd_0/2321 is trying to acquire lock:
 (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]

but task is already holding lock:
 (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]

other info that might help us debug this:
2 locks held by knodemgrd_0/2321:
 #0:  (nodemgr_serialize){--..}, at: [<c11e76cd>]
mutex_lock_interruptible+0x1c/0x21
 #1:  (&s->rwsem){----}, at: [<f8959078>]
nodemgr_host_thread+0x717/0x883 [ieee1394]

stack backtrace:
 [<c1003c97>] dump_trace+0x69/0x1b7
 [<c1003dfa>] show_trace_log_lvl+0x15/0x28
 [<c10040f5>] show_trace+0x16/0x19
 [<c1004110>] dump_stack+0x18/0x1d
 [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
 [<c102f70a>] lock_acquire+0x56/0x74
 [<c102b805>] down_write+0x27/0x41
 [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
 [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
 [<c1028c19>] kthread+0xaf/0xde
 [<c100397b>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [<c1003dfa>] show_trace_log_lvl+0x15/0x28
 [<c10040f5>] show_trace+0x16/0x19
 [<c1004110>] dump_stack+0x18/0x1d
 [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
 [<c102f70a>] lock_acquire+0x56/0x74
 [<c102b805>] down_write+0x27/0x41
 [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
 [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
 [<c1028c19>] kthread+0xaf/0xde
 [<c100397b>] kernel_thread_helper+0x7/0x10
 =======================
ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[0080880002103eae]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
