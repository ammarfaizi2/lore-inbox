Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTE2Ocp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTE2Ocp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:32:45 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:23816 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262268AbTE2Ocn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:32:43 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Thu, 29 May 2003 16:45:26 +0200
User-Agent: KMail/1.5.2
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local>
In-Reply-To: <20030529135508.GC21673@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305291607.33211.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 15:55, Willy Tarreau wrote:

Hi Willy,

> I've done a few tests with -rc6 on my dev machine (dual xp 1.5G, 512 MB,
> scsi). It's the *FIRST* time I have ever seen my mouse cursor hang (just a
> little bit however, and totally acceptable) ! Usually, my kernel include -aa
> VM and lowlat patches, and I've never encountered this behaviour on this
> machine with such a configuration. However, with stock kernel, I admit that
> during the 2 minutes it takes to write the 2G file, I see the mouse stick
> two or three times during about 1 second, which is quite acceptable IMHO.
WRONG. A mouse stick is not acceptable in _any_ way. Other OS' can handle this 
pretty well, and if Linux has problems with mouse sticks, this has to be 
fixed! Either in kernel space or in userspace (XFree86).

> Opening an xterm may take 10s to get to the prompt (more annoying). Same to
> launch 'ps'.
ACK!

> I retried with rc4aa1, and everything went very smooth again ; it takes at
> most 1 second to get an xterm with the prompt ready, and ps responds
> immediately. So I think that there are two things here:
>   - those who experience very long hangs may use a heavy window manager
>     which does continuous disk accesses (I mean it accesses the disk for
>     any simple operation).
>   - a hungry WM may also be swapped during such operations, rendering it
>     totally unusable, particularly if the swap is on the same physical disk
>     as the file being written to.
Well, sorry, but: no!

The pauses/stops occurs no matter of what WindowManager (KDE2/3, WindowMaker, 
fvwm, gnome etc. foobar). The point why you are not seeing such things with 
-aa is his Lowlatency Elevator and lowlatency-fixes and some important fixes 
which are not in stock kernel yet.

I reproduced mouse sticks and keyboard does not accept anything problems for 
$seconds with _every_ kernel which is based on 2.4.19/2.4.20/2.4.21*. This 
also includes -AA (well, not that braindead bad like mainline did before the 
fix) but this is because of lowlat elevator from Andrea. And as I told 
yesterday (or 2 days ago? dunno) lowlat elevator drops throughput (Andrea, it 
_does_ ;).

It's not just only mouse hangs (as I've reported tons of times) but also 
keyboard does not accept any input (delay varies between 1 to 15 seconds) and 
this also applies if you don't run X at all.

Another fine example is:

- Start a screen session, not running X at all.
- Trash your HD with tons of writes.
- Press Ctrl-A-C for a new screen session.

You will see, it takes as long as, you wrote above, with starting up an Xterm 
or calling ps. It does _not_ happen with 2.4.18!

> So, could the people who report long hangs retry with swap disabled ?
It's somewhat better but not acceptable.

> Can we limit the amount of memory consummed by the cache during such a
> write ?
I ask for such a feature since years ;)

Well, my summary: The bug is there, for over 15 months ( I won't mention it 
again that I've reported the bug 15 months ago ;-) ... It _may_ be some very 
obscure hardware problem to be able to reproduce this bug but as this thread 
shows up, there are tons of people who can reproduce this with different 
hardware starting with 2.4.19-pre1.

ciao, Marc

