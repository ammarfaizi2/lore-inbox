Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVCCUaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVCCUaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCCU1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:27:41 -0500
Received: from alog0203.analogic.com ([208.224.220.218]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262169AbVCCUWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:22:48 -0500
Date: Thu, 3 Mar 2005 15:20:55 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: V P <upathiyayan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: I/O error propagation
In-Reply-To: <c9ad856005030311286314ebfd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503031506410.7559@chaos.analogic.com>
References: <c9ad856005030311286314ebfd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, V P wrote:

> Hi,
>
> I have a question on how disk errors get propagated to
> the file systems.
>
>> From looking at the SCSI/IDE drivers, it looks like there
> could be many reasons for an I/O to fail. It could be
> bus timeout, media errors, and so on.
>
> Does all these errors get reported to the file system ?
> It looks like all the different types of errors get
> turned into a single I/O error (-EIO) and passed on to the
> file system.
>
> Or is there a way where we can export better error codes
> to the file system ?
>
> Any idea/input regarding this is greatly appreciated.
>
> Thanks.

It depends upon the disk devices, i.e., IDE SCSI, etc., but in
general all errors reported by the hardware result in retrying
the operation. If the retry fails after several (device dependent)
attempts, the actual error is reported as a kernel message. These
errors can be retrieved using the `dmesg` command and they
will usually be retained in some kernel log in /var/log (actual
log-name is vendor dependent).

Following the Unix convention, any errors reported back upstream,
eventually to the user, get reported ONLY as something defined
in /usr/include/errno.h (which includes others, ultimately
/usr/asm/errno.h).

So, you don't need to reinvent anything. If you have hardware
errors they will be reported in /var/log/messages (or whatever)
and if you are making a new driver, you are expected to comply
with the same protocol.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
