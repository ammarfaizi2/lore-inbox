Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318111AbSHPEAH>; Fri, 16 Aug 2002 00:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318112AbSHPEAH>; Fri, 16 Aug 2002 00:00:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318111AbSHPEAH>; Fri, 16 Aug 2002 00:00:07 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ptrace/select/signal errno weirdness
Date: 15 Aug 2002 21:03:52 -0700
Organization: Transmeta Corporation
Message-ID: <ajhtj8$ns6$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208151508060.21876-100000@spratly.nominum.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208151508060.21876-100000@spratly.nominum.com>,
Brian Wellington  <bwelling@xbill.org> wrote:
>When sending a SIGINT to a ptraced process (run under gdb), an interrupted 
>select() call returns with errno==514.  linux/include/linux/errno.h says:
>
>/* Should never be seen by user programs */
>#define ERESTARTSYS     512
>#define ERESTARTNOINTR  513
>#define ERESTARTNOHAND  514     /* restart if no handler.. */
>#define ENOIOCTLCMD     515     /* No ioctl command */
>
>As gdb is a user program, and the printf is printing it, there's something
>wrong.

No, there's nothing wrong.

The process _itself_ never sees these magic error numbers, because they
are internal to the kernel, and the only time they are seen is by a
tracer that sees them - at the same time as the kernel backed up the
instruction pointer so that the traced process will not actually return
from the system call, it will re-do the system call.

		Linus
