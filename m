Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285184AbRLFLGN>; Thu, 6 Dec 2001 06:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285185AbRLFLGE>; Thu, 6 Dec 2001 06:06:04 -0500
Received: from firebird.epm.se ([194.52.86.60]:21510 "EHLO www.voxi.se")
	by vger.kernel.org with ESMTP id <S285184AbRLFLFu>;
	Thu, 6 Dec 2001 06:05:50 -0500
Message-ID: <3C0F510C.E535A9A8@voxi.com>
Date: Thu, 06 Dec 2001 12:05:48 +0100
From: Erland Lewin <erl@voxi.com>
Organization: Voxi AB
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christian Robottom Reis <kiko@async.com.br>
Subject: /proc/<pid>/stat read hang with Mozilla in 2.4.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, September 3, Christian Reis wrote to linux-kernel:
> Just wondering if anybody has had moz hanging on them and hanging 'ps -ax' 
> (which means /proc/kmem reading is hung, IIRC)? This _never_ happened 
> before 2.4.9, and I do mozilla QA so I'd have seen it; i've seen all sorts 
> of crash with it :) 

On Sun, September 30, Manfred Spraul replied:
> Probably you ran into the bug Ulrich Weigand found:
> access_process_vm can deadlock, especially with multithreaded apps.
> Access_process_vm is used by /proc/*/cmdline.
> 
> It's fixed in 2.4.10.

I am seeing this problem (Mozilla hangs, then ps hangs (even a normal ps
without args)) in kernel 2.4.14 on an SMP machine (Abit BP6 mobo).
  I did an strace of ps (procps 2.0.4) which ends with:

...
stat64("/proc/8770", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/8770/stat", O_RDONLY)       = 7
read(7, > 

I can't kill the 8770 process with kill -9 8770 (the /proc/8770
directory still exists).
  I had recompiled Mozilla while a copy was running, could this have
caused the problem?
  I also get hangs reading the cmdline, environ, exe, maps, stat, statm
and status files.
  I can read the fd directory, the cpu file, the root and cwd links.
  If I try to read the mem file, I get: "cat: /proc/8770/mem: No such
process".
  There are no unusual messages in the system logs.

I guess I'll have to reboot now to make the dead Mozilla go away.
  Please CC: any replies to me, as I don't subscribe to the linux-kernel
list.

  Happy Hacking,

    Erland
