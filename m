Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319001AbSHMRhZ>; Tue, 13 Aug 2002 13:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319003AbSHMRhZ>; Tue, 13 Aug 2002 13:37:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31243 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319001AbSHMRhX>; Tue, 13 Aug 2002 13:37:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc and logging
Date: 13 Aug 2002 10:41:03 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajbgbf$7e7$1@cesium.transmeta.com>
References: <3D58B14A.5080500@zytor.com> <ajaka7$qb6$1@ncc1701.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <ajaka7$qb6$1@ncc1701.cistron.net>
By author:    "Miquel van Smoorenburg" <miquels@cistron.nl>
In newsgroup: linux.dev.kernel
>
> In article <3D58B14A.5080500@zytor.com>,
> H. Peter Anvin <hpa@zytor.com> wrote:
> >However, I'm wondering what to do about logging.  Kernel log messages 
> >get stored away until klogd gets started, but early userspace may need 
> >some way to log messages -- and syslog is obviously not running.  The 
> >easiest way to do this would probably be to be able to write to 
> >/proc/kmsg (which probably really should be /dev/kmsg) and push messages 
> >onto the kernel's message queue; but we could also have a dedicated 
> >location in the initramfs for writing logs, and do it all in userspace. 
> 
> /dev/shm/log/ ?
> 

Requires too much to work before it's can be made available.

Andrew Morton sent me a proposed patch last night which adds a klogctl
(a.k.a. sys_syslog) which does a printk() from userspace.  It was less
than 10 lines; i.e. probably worth it.  I have hooked this up to
syslog(3) in klibc, although the code is not checked in yet.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
