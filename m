Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280953AbRKGUEA>; Wed, 7 Nov 2001 15:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKGUDu>; Wed, 7 Nov 2001 15:03:50 -0500
Received: from fe5.southeast.rr.com ([24.93.67.52]:31241 "EHLO mail5.nc.rr.com")
	by vger.kernel.org with ESMTP id <S280947AbRKGUDk>;
	Wed, 7 Nov 2001 15:03:40 -0500
Subject: Re: Linux-2.4.[10-13]-acX slows down to crawl...
From: "C. Linus Hicks" <lhicks@nc.rr.com>
To: Andreas.Franck@akustik.rwth-aachen.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE95E9C.D62D372C@akustik.rwth-aachen.de>
In-Reply-To: <3BE95E9C.D62D372C@akustik.rwth-aachen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 07 Nov 2001 12:29:33 -0500
Message-Id: <1005154173.2537.37.camel@lh2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Nov 2001 17:17:32 +0100, Andreas Franck wrote:
> Hello folks,
> 
> since quite a time (it happens at least since 2.4.10-ac, and also
> happens with the newest -ac kernel 2.4.13-ac8), Linux gets slower
> and slower, to a state where it is basically unusable after some days.
> I suspect it is a VM issue, because it starts swapping without any
> need, not freeing buffers? The buffer sizes are about the size of RAM
> when it is worst. For anything done, the load goes up extremely, network
> access basically halts the machine then, leading to a load of about 20
> :-(

I did not look closely at what was happening, but I experienced a
similar slowdown on 2.4.9-ac11. It took a while in my case, (several
weeks) as I have 1gb memory and don't have any massive files on my
system. I have dual PIII 1GHz CPUs and was downloading a 300mb file when
I started xpdf on a document that has lots of complex drawaings. The
download rate was 200-250kbps prior to starting xpdf and dropped to
20-40. If I stopped the download and restarted, it ran at 200-250 until
I ran xpdf again (that it was running did not seem important, but when I
displayed a new page and it ate a CPU). I thought it might be something
with xpdf because I was able to reproduce an xpdf slowdown by running
three copies at the same time.

However, now I am running 2.4.12-ac6 booted last night and I have seen
the slowdown in xpdf running just one. Last night after I re-booted, it
was running fine. The strange thing is that when this happens, the
system acts like it has no spare CPU because even switching to another
window takes a long time for the focus to change.

top reports:

 12:21pm  up 11:36, 16 users,  load average: 0.30, 0.13, 0.09
140 processes: 138 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  0.5% user,  0.4% system,  0.0% nice, 98.1% idle
CPU1 states: 99.3% user,  0.2% system,  0.0% nice,  0.0% idle
Mem:  1028936K av,  817768K used,  211168K free,    4152K shrd,  282336K
buff
Swap: 2000880K av,       0K used, 2000880K free                  189408K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1117 root      18   0 75864  34M  5972 R    99.9  3.3 342:36 X
 5491 linush    14   0  1016 1016   768 R     1.1  0.0   0:09 top
 4859 linush     9   0  3544 3544  1616 S     0.5  0.3   0:04 xpdf
    1 root       8   0   528  528   460 S     0.0  0.0   0:01 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd

Let me know if I can be of any assistance.

Linus


