Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTIOFxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTIOFxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:53:31 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:59264
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262439AbTIOFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:53:29 -0400
Date: Mon, 15 Sep 2003 01:53:26 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: intermittent crash on chvt to X; was console lost
Message-ID: <Pine.LNX.4.44.0309150150250.377-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been experiencing something similar to this.

With 2.6.0-test4+ if I start X, and switch consoles back and forth
randomly, eventually the system will lock hard. I am unable to get a panic
dump because the system state is completely dead (except oddly, the
numlock key still works w/ LED).

I am unsure why this is ocurring or if this is related to this issue.

Thanks,

Shawn S.

---------------------


List:     linux-kernel
Subject:  Re: 2.6.0-test5: intermittent crash on chvt to X; was console
lost
From:     Pat LaVarre <p.lavarre () ieee ! org>
Date:     2003-09-14 23:04:25
[Download message RAW]

> qestion now is whether this is kernel or X related.

Oh.

> > echo ... | tee -a $log
> > sync
> > sleep $wait
> > chvt ...
> > sleep $wait
>
> the crash may (in your case does) happen later

In repeating those five commands, is there any purpose to the first
sleep?  I left the first sleep in place to match the original, but once
I assume sync leaves no writes unflushed then now I do not see what the
first sleep accomplishes, if anything.

> Have you had this problem with an earlier 2.6 or 2.4 kernel?

Today 2.4.21-xfs Knoppix booted via cd:
in over 75 cycles I saw no crash so I gave up.

Today 2.4.22 with a near default .config:
"in over 75 cycles I saw no crash so I gave up".

Today 2.6.0-test4 with a near default .config:
Counting cycles before crash per boot I saw: 3 2 16 ...

Yester/today 2.6.0-test5 with a near default .config:
"I saw: 1 18 20 20 ... 4 16 ..." 3 ...

> -test5, post (as tar.bz2) ...

After that last -test5 crash I rebooted and then produced the attached
via:

#!/bin/bash
# rm -r chvtx
mkdir chvtx

sudo /sbin/lspci -v >>chvtx/v.lspci
sudo cat /var/log/dmesg >>chvtx/var.log.dmesg
egrep -i 'version|release|driver' /var/log/XFree86.*.log
>>chvtx/var.log.XFree86.log
# cp -ip /var/log/XFree86.*.log chvtx/
cp -ip .config chvtx/config

tar -c chvtx | bzip2 -zc >chvtx.2.6.0-test5.tar.bz2

# Pat LaVarre

