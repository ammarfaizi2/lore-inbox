Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263614AbSITU4Z>; Fri, 20 Sep 2002 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263625AbSITU4Z>; Fri, 20 Sep 2002 16:56:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:37828 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263614AbSITU4Y>;
	Fri, 20 Sep 2002 16:56:24 -0400
Message-ID: <3D8B8C3B.DC338334@digeo.com>
Date: Fri, 20 Sep 2002 13:59:39 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Sinz <msinz@wgate.com>
CC: mks@sinz.org, marcelo@conectiva.com.br, Robert Love <rml@tech9.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B87C7.7040106@wgate.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 20:59:42.0484 (UTC) FILETIME=[A44ACD40:01C260E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Sinz wrote:
> 
> coredump name format control via sysctl
> 
> Provides for a way to securely move where core files show up and to
> set the name pattern for core files to include the UID, Program,
> Hostname, and/or PID of the process that caused the core dump.

Seems a reasonable thing to want to do.

> ...
> 
>        %P   The Process ID (current->pid)
>        %U   The UID of the process (current->uid)
>        %N   The command name of the process (current->comm)
>        %H   The nodename of the system (system_utsname.nodename)
>        %%   A "%"
> 
> For example, in my clusters, I have an NFS R/W mount at /coredumps
> that all nodes have access to. The format string I use is:
> 
>         sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"

Does it need to be this fancy?  Why not just have:

	if (core_name_format is unset)
		use "core"
	else
		use core_name_format/nodename-uid-pid-comm.core

which saves all that string format processing, while giving
people everything they could want?
