Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUCLRql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUCLRql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:46:41 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:51849 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S262008AbUCLRqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:46:15 -0500
Message-ID: <4051F8B2.9010003@brad-x.com>
Date: Fri, 12 Mar 2004 12:51:46 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com>	<20040310155712.7472e31c.akpm@osdl.org>	<4050271C.3070103@brad-x.com>	<40503120.9000008@brad-x.com> <20040311020832.1aa25177.akpm@osdl.org>
In-Reply-To: <20040311020832.1aa25177.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070609050704010702050900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609050704010702050900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Brad Laue <brad@brad-x.com> wrote:
> 
>> Brad Laue wrote:
>> > Hopefully the attached shows some irregularity. If not, I'll have to 
>> > reply back in a few weeks when the problem recurs over the course of time.
>>
>> And without further ado, the attachment. It's been a long day. :)
> 
> 
> It beats me.  Something must be waking up ksoftirqd all the time.
> 
> If you have time, could you please apply the below, then wait for ksoftirqd
> to go bad again and then run:
> 
> 
> 	dmesg -c
> 	echo 1 > /proc/sys/debug/0 ; sleep 1; echo 0 > /proc/sys/debug/0
> 	dmesg -s 1000000 > /tmp/foo
> 
> and then send foo?
> 

Okay, it looks like the 'pppoe' process is definitely causing all the
soft interrupts. Puzzling, because on other systems with similar
hardware this doesn't happen. Ran the machine without iptables running
(eek!!!) just to make sure, and the same result occurred, so it doesn't
seem to be the fact that packets are going through an elaborate ruleset
that's causing it. Kernel mode PPPoE doesn't seem to change things much.

Hard to figure out from a kernel perspective why this many soft 
interrupts are being used, but I'm just getting a grasp on what their 
purpose is to begin with.

Hope this offers some insight.

Brad

--------------070609050704010702050900
Content-Type: text/plain;
 name="wakes_softirqd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wakes_softirqd"

ction+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c02978b3>] net_tx_action+0x83/0xd0
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c02978b3>] net_tx_action+0x83/0xd0
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

pppoe wakes ksoftirqd
Call Trace:
 [<c0121e6c>] __tasklet_schedule+0x7c/0x80
 [<d084656c>] ppp_asynctty_receive+0xbc/0xd0 [ppp_async]
 [<c024a342>] pty_write+0x142/0x1d0
 [<c0249333>] write_chan+0x1f3/0x220
 [<c011a910>] default_wake_function+0x0/0x20
 [<c011a910>] default_wake_function+0x0/0x20
 [<c0243d38>] tty_write+0x1e8/0x290
 [<c0249140>] write_chan+0x0/0x220
 [<c0243b50>] tty_write+0x0/0x290
 [<c0151fa8>] vfs_write+0xb8/0x130
 [<c01520d2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb



--------------070609050704010702050900
Content-Type: text/plain;
 name="profile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile"

c013df00 kmem_cache_alloc                              2   0.0312
c013df90 __kmalloc                                     2   0.0156
c01d8900 xfs_ilock                                     2   0.0114
c0204390 linvfs_write                                  2   0.0069
c02475f0 n_tty_write_wakeup                            2   0.0312
c0247630 n_tty_receive_buf                             2   0.0005
c024a200 pty_write                                     2   0.0043
c0121cc0 local_bh_enable                               3   0.0208
c016d180 dnotify_parent                                3   0.0156
c0215eb0 fast_clear_page                               3   0.0312
c0109354 system_call                                   4   0.0909
c0138300 generic_file_aio_write_nolock                 4   0.0015
c0151e30 do_sync_write                                 4   0.0208
c0151ef0 vfs_write                                     4   0.0132
c0155e10 generic_commit_write                          4   0.0227
c0164ce0 sys_select                                    4   0.0032
c016bde0 inode_update_time                             4   0.0192
c0243a00 tty_read                                      4   0.0119
c0243b50 tty_write                                     4   0.0061
c0126040 run_timer_softirq                             5   0.0116
c013a580 free_hot_cold_page                            5   0.0195
c0164900 max_select_fd                                 5   0.0223
c0215974 csum_partial                                  5   0.0174
c02488e0 read_chan                                     5   0.0023
c0152ee0 fget                                          6   0.0938
c01551f0 __block_prepare_write                         6   0.0059
c01649e0 do_select                                     6   0.0083
c0213930 radix_tree_lookup                             6   0.0750
c011a990 __wake_up                                     8   0.0833
c013e060 kfree                                         9   0.0804
c01b0ed0 xfs_bmapi                                     9   0.0018
c01862a0 write_profile                                10   0.1562
c0208de0 xfs_write                                    10   0.0047
c0216440 __copy_from_user_ll                          17   0.1328
c011a340 schedule                                     18   0.0128
c010ad50 handle_IRQ_event                             21   0.1875
c02163d0 __copy_to_user_ll                            27   0.2411
c0121c00 do_softirq                                  144   0.7500
c0107030 default_idle                               8696 181.1667
00000000 total                                      9144   0.0060


--------------070609050704010702050900--
