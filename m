Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272386AbRIFHKu>; Thu, 6 Sep 2001 03:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272389AbRIFHKi>; Thu, 6 Sep 2001 03:10:38 -0400
Received: from maa3.cc.lut.fi ([157.24.8.133]:30216 "EHLO maa3.cc.lut.fi")
	by vger.kernel.org with ESMTP id <S272386AbRIFHK0>;
	Thu, 6 Sep 2001 03:10:26 -0400
Date: Thu, 6 Sep 2001 10:10:45 +0300 (EEST)
From: Mika Yrj|l{ <myrjola@lut.fi>
Reply-To: <myrjola@lut.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Weird behaviour / Trying to vfree() nonexistent vm area message
Message-ID: <Pine.LNX.4.33.0109060931430.27506-100000@maa3.cc.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

although I'm not subscribed to the list, I thought to post this message
because I ran last night into rather exotic behaviour, which could be
kernel-related. I initially posted to a finnish Linux group and was
recommended to duplicate the message here. A rough translation of the
message follows:

I initially noticed that Mozilla didn't respond to user input anymore.
Because of that, I thought to look for the PID with ps and kill it.
However, ps printed just a few lines and stopped. The terminal window
still received keypresses, but the output of ps didn't continue and
control-c did not break the process. That started to feel a bit weird and
I tried to run top. This didn't print anything and behaved in the same way
as ps. I also encountered this problem with w and killall. However, I
could get still process information from relevant /proc/<pidnumber>/
files. Additionally, a few lines of C which just printed out the result of
getpid() call worked nicely.

Additionally, about the same time I noticed the problem an entry to
/var/log/messages had appeared:

Sep  6 02:55:40 renttu kernel: Trying to vfree() nonexistent vm area
(d59d4000)

I tried running "strace ps". The problem seems to be related to the
following final lines of output:

getdents64(6, /* 20 entries */, 1024)   = 576
stat64("/proc/864", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/864/stat", O_RDONLY)        = 7
read(7,

After that nothing happens. I tried manually reading the corresponding
file, but the same effect happens with "cat /proc/864/stat". Seems that
this process (whatever is may be... can't get information about it) is the
culprit somehow.

The kernel/hardware information:

[myrjola@renttu ~]$ uname -a
Linux renttu.lnet.lut.fi 2.4.8 #1 Mon Aug 13 07:15:39 EEST 2001 i686
unknown

TB 1200 MHz (not overclocked), A7M266, 256 megabytes of DDR memory,
Sblive!, Geforce 2MX, two IBM hard disks and HP cd-rw drive

If the possible comments would be CC'ed to this address, I'd be grateful.
Also, I'm keeping the machine up and running in that state until today
evening in case someone wants me to test something that could be useful in
finding the cause.

-- 
/-------------------------------------------------------------------------\
I Fantasy, Sci-fi, Linux, Amiga, Telecommunications, Oldfield, Vangelis    I
I Seti@Home, Steady relationship, more at http://www.lut.fi/%7emyrjola/    I
\-------------------------------------------------------------------------/

