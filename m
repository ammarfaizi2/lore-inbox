Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266192AbRGJKqg>; Tue, 10 Jul 2001 06:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbRGJKqZ>; Tue, 10 Jul 2001 06:46:25 -0400
Received: from potato.vegetable.org.uk ([195.149.39.120]:43455 "EHLO
	potato.vegetable.org.uk") by vger.kernel.org with ESMTP
	id <S266192AbRGJKqS>; Tue, 10 Jul 2001 06:46:18 -0400
To: linux-kernel@vger.kernel.org
Subject: No data in `w' and `top'
From: Tim Haynes <kernel@stirfried.vegetable.org.uk>
Reply-To: kernel@stirfried.vegetable.org.uk (Tim Haynes)
Date: 10 Jul 2001 11:46:08 +0100
Message-ID: <86r8vp3vv3.fsf@potato.vegetable.org.uk>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As of kernel 2.4.5 I'm getting two symptoms:

 | bash$ w
 |  11:27:35 up 1 day, 21:24, 16 users,  load average: 0.06, 0.04, 0.00
 | USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
 | bash$
(note lack of actual data)

and in top:

 |  11:42:22 up 1 day, 21:39, 12 users,  load average: 0.08, 0.04, 0.01
 | 0 processes: 0 sleeping, 0 running, 0 zombie, 0 stopped
 | CPU states:   0.2% user,   0.4% system,   0.0% nice,  99.4% idle
 | Mem:    188756K total,   175548K used,    13208K free,    26508K buffers
 | Swap:   257000K total,    19020K used,   237980K free,    98708K cached
 | 
 |   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 | 
 | 
 | 
 | 

(tends to 100.0% idle over time - refresh interval of 3s.)

In either case, this sits around for about 10s and then normal service is
resumed. During outages, the rest of the box behaves as normal.

I was informed this is due to a `locking issue' that only ReiserFS stumbled
upon (the above happened most times when I write to /home or /var/log, both
of which are ReiserFS), and that it was fixed in 2.4.6 (pre3). I'm now
running 2.4.7-pre3 and it *still* occurs, although not as frequently as
before (was roughly 2 out of every 3 writes to a reiser partition; now less
than predictable).

Data: Debian/Testing updated daily. Filesystems used:

    /dev/hda1 on / type xfs (rw)
    /dev/hda4 on /var/spool type xfs (rw,noexec,nosuid,nodev)
    /dev/hda5 on /var type reiserfs (rw,nosuid,nodev,noatime)
    /dev/hda7 on /usr/local type reiserfs (rw)
    /dev/hda8 on /home type reiserfs (rw,nosuid,nodev,noatime)

If anyone else has experienced this and/or has clues what's going wrong,
I'd be grateful.

TIA,

~Tim
-- 
<http://spodzone.org.uk/>
