Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQJ3UB7>; Mon, 30 Oct 2000 15:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbQJ3UBt>; Mon, 30 Oct 2000 15:01:49 -0500
Received: from imladris.infradead.org ([194.205.184.45]:62992 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S129049AbQJ3UBh>;
	Mon, 30 Oct 2000 15:01:37 -0500
Date: Mon, 30 Oct 2000 20:01:32 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.X patch query
Message-ID: <Pine.LNX.4.10.10010301935480.10495-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

You may remember a while back a suggestion that panic messages be
dumped to floppy so they can be read afterwards.

I've been looking into this idea for a while, in between working on my
plans to get married, and looking for a job somewhere, and I think I
have the bones of it laid out now.

I'm NOT planning on making panics automatically dump to floppy. What I
was looking at instead was to add a SysRq option to dump the current
syslog buffer to floppy. This would be available at any time, but ONLY
if the kernel has SYSRQ support compiled in, and has additionally
enabled CONFIG_SYSRQ_DUMPLOG (which appears when SYSRQ is enabled). In
addition, it would need to be enabled at runtime, probably by writing
to a root-owned /proc file with 0600 permissions.

Before I go any further with this, I would like to ask a few questions
relating to it:

 1. Is there any likelihood of this making it into the official
    kernel, or am I just wasting my time?

 2. Would I be right in thinking it's too late for either the
    2.2 or 2.4 kernels ???

Assuming it'd be of interest to Linus and yourself...

 3. My investigations so far have indicated that the current
    syslog buffer at 16k is too small to guarantee that all
    the relevant messages are still there. I would therefore
    be looking at increasing this to at least 32k, and would
    probably include a config menu to select the size to use
    if CONFIG_SYSRQ_DUMPLOG is enabled, offering 32k, 64k,
    128k, 256k, 512k and 1M as options.

    Would this cause any problems?

 4. My choice would be to use SYSRQ-D to activate this. Are
    there any other plans for that combination, that you are
    aware of?

 5. I was wondering about providing some means of selecting
    whether to dump to /dev/fd0 or /dev/fd1 (or others if
    present). What would be your opinion on this?

 6. A while back, I developed a high-level floppy formatter
    that produces a non-standard DOS-compatible format that
    allows 1436k of data on a 1440k floppy, and produced a
    bash script that would produce disks formatted in this
    format.

    My current plans are for SYSRQ-D to raw write direct to
    /dev/fd0 and effectively reformat the disks in this
    format, dropping the log file thereon in the process. I
    don't plan on doing the low-level format, just the
    high-level one.

    Can you see anything wrong with this idea?

Best wishes from Riley.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
