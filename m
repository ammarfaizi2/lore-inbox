Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSHPFBg>; Fri, 16 Aug 2002 01:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSHPFBf>; Fri, 16 Aug 2002 01:01:35 -0400
Received: from waste.org ([209.173.204.2]:30374 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318169AbSHPFBf>;
	Fri, 16 Aug 2002 01:01:35 -0400
Date: Fri, 16 Aug 2002 00:05:31 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
Message-ID: <20020816050531.GB5418@waste.org>
References: <3D58B14A.5080500@zytor.com> <ajaka7$qb6$1@ncc1701.cistron.net> <ajbgbf$7e7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajbgbf$7e7$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:41:03AM -0700, H. Peter Anvin wrote:
>
> Andrew Morton sent me a proposed patch last night which adds a klogctl
> (a.k.a. sys_syslog) which does a printk() from userspace.  It was less
> than 10 lines; i.e. probably worth it.  I have hooked this up to
> syslog(3) in klibc, although the code is not checked in yet.

Don't like it. First, it sounds like overkill. Second it's got some
interesting security implications - only root should be able to flood
the kernel message queue, but non-root should be able to syslog, even
from early userspace. Third, if the only user is klibc, then it's
working against the early userspace's concept of simplifying the kernel.

Why not simply create a file on the initramfs, open it append, spool
raw user and kernel messages to it, then copy that file into the real
syslogd's socket when it becomes available? The "hard" part of syslogd
is the filtering, copying raw messages from socket to file is easy..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
