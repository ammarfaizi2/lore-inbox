Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbTH1SVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTH1SVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:21:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264116AbTH1SVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:21:49 -0400
Date: Thu, 28 Aug 2003 14:21:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tony Lill <ajlill@tardis.ajlc.waterloo.on.ca>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: generate modprobe.conf
In-Reply-To: <200308281702.h7SH2uql011425@spider.ajlc.waterloo.on.ca>
Message-ID: <Pine.LNX.4.53.0308281417580.3807@chaos>
References: <200308271142.40104.cijoml@volny.cz> <3F4C81DD.6020608@basmevissen.nl>
 <200308271206.35069.cijoml@volny.cz> <3F4C893B.5030203@basmevissen.nl>
 <200308281702.h7SH2uql011425@spider.ajlc.waterloo.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003, Tony Lill wrote:

> Bas Mevissen <ml@basmevissen.nl> writes:
> > Hmmm. Strange. But it doesn't look like a kernel problem, but a system
> > configuration problem. So I'll take this off LKML and see if I can
> > help you by private e-mail.
>
> Unless there's a linux-kernel-broke-my-sytem-but-its-not-really-its-fault
> mailing list I can subscribe to, please keep the discussion here. I've
> got simmilar problems, and any solution may be enlightening.
> --
> Tony Lill,                         Tony.Lill@AJLC.Waterloo.ON.CA
> President, A. J. Lill Consultants        fax/data (519) 650 3571
> 539 Grand Valley Dr., Cambridge, Ont. N3H 2S2     (519) 241 2461
> --------------- http://www.ajlc.waterloo.on.ca/ ----------------
> "Welcome to All Things UNIX, where if it's not UNIX, it's CRAP!"

Well, to start, become root and execute `modprobe -c >junk`.
The file, junk, now contains everything modprobe 'knows' about.
You can use this as a reference.

Let's say that you have a new device, a character device with
a major number of 177. You want a module to be automatically
loaded upon the first access to that device. You simply insert
the following lines in /etc/modules.conf.

path[my-module]=/complete/path/to/where/you/put/it
alias char-major-177 my-module

Normally, you keep all the paths together and the aliases
sorted to make sense to humans. The software doesn't care.
Also, "my-module" is the module file-name without the ".o"

You only need paths if the module is not in a standard
place like 'lib/modules/`uname -r`/kernel. The file
/lib/modules/`uname -r`/modules.dep, contains all the
dependency information for everything, generated with
the `depmod -a` command.

Maybe somebody has a script that configures this auto-magically,
however I've never seen it and haven't had to use it. Problems
with finding modules with new kernel versions usually are the
result of a change in the directory structure under
/lib/modules/`uname -r`/ so you might want to make several
/etc/modules.conf files if you boot several widely-different
kernel versions. Just fix up the paths where required.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


