Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVALPEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVALPEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVALPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:04:46 -0500
Received: from alog0436.analogic.com ([208.224.222.212]:13952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261207AbVALPEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:04:39 -0500
Date: Wed, 12 Jan 2005 10:04:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with syscall macro
In-Reply-To: <20050112144047.51119.qmail@web53305.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0501120944130.9477@chaos.analogic.com>
References: <20050112144047.51119.qmail@web53305.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, sounak chakraborty wrote:

>  i am writing a program which willcopy all the lines
> from system log file /var/log/messages and put it in a
> user log file
> i am using syslog with syscall3 but when i am using
> write system cal it is not able to write anything
> do i have to add something more
> i have added the syscall3 macro for write too
> do i have to do it for open system call also
> i am little bit confuse with the kernel-user mode
> switching concept too
> could you please help me out
> thans
> sounak
>

You are very confused. The "stuff" that comes from the
kernel, printk(), etc., is buffered by the kernel and
then read by user-mode code from /proc/kmsg.

But, once you read it, it's gone. Therefore there is
a procedure,  int syslog(int type, char *buf, int buf_len);
that allows a user to read/manuiplate the logging
facility. `man syslog` will get you that information.
You do __not__ use _syscall3(). See the underscore in
the name? Things that begin with underscores are used by
the 'C' runtime library, not you directly.

#include <stdio.h>
#include <sys/syslog.h>
int main() {
     char buf[0x2000];
     syslog(3, buf, sizeof(buf));
     puts(buf);
     return 0;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
