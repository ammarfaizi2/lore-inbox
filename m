Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSHMCWE>; Mon, 12 Aug 2002 22:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSHMCWE>; Mon, 12 Aug 2002 22:22:04 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:9469 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318911AbSHMCWD>;
	Mon, 12 Aug 2002 22:22:03 -0400
Date: Mon, 12 Aug 2002 22:25:50 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020813022550.GA6810@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5857A4.FE358FA2@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 05:49:40PM -0700, Andrew Morton wrote:
> Adam Kropelin wrote:
> > 
> > ...
> > > You can make 2.5 use the 2.4 settings with
> > >
> > > cd /proc/sys/vm
> > > echo 30 > dirty_background_ratio
> > > echo 60 > dirty_async_ratio
> > > echo 70 > dirty_sync_ratio
> > 
> > These settings bring -akpm in line with stock 2.5.31, but they are both
> > still slower than 2.4.19 (which itself could do better, I think).
> 
> In that case I'm confounded.  It worked sweetly for me.  Just

> Which ftp client are you using?  And can you strace it, to see how
> much data it's writing per system call?

Actually, I'm running an FTP server on the testbed machine and pushing the
data from a client on another (much faster) machine. I straced the server
(redhat wu-ftpd2.6.1-20) and it looks like 8 KB reads/writes.

After the transfer gets going...

1329  read(8, "v&X\205:\327.+\310/a\335\24Sa\361c\243\r\244\260~\264z"..., 8192) = 8192
1329  write(7, "v&X\205:\327.+\310/a\335\24Sa\361c\243\r\244\260~\264z"..., 8192) = 8192
1329  rt_sigaction(SIGALRM, {0x804b030, [ALRM], SA_RESTART|0x4000000}, {0x804b030, [ALRM], SA_RESTART|0x4000000}, 8) = 0
1329  alarm(1200)                       = 1200
1329  read(8, "\335\235\335\35}\335]\375\17\373|\324VS[\r\266Af\333\246"..., 8192) = 8192
1329  write(7, "\335\235\335\35}\335]\375\17\373|\324VS[\r\266Af\333\246"..., 8192) = 8192
1329  rt_sigaction(SIGALRM, {0x804b030, [ALRM], SA_RESTART|0x4000000}, {0x804b030, [ALRM], SA_RESTART|0x4000000}, 8) = 0
1329  alarm(1200)                       = 1200
1329  read(8, "\302\365SV4\24{*\341\336\24\213\242\363\307\36\274\377"..., 8192) = 8192
1329  write(7, "\302\365SV4\24{*\341\336\24\213\242\363\307\36\274\377"..., 8192) = 8192
1329  rt_sigaction(SIGALRM, {0x804b030, [ALRM], SA_RESTART|0x4000000}, {0x804b030, [ALRM], SA_RESTART|0x4000000}, 8) = 0
1329  alarm(1200)                       = 1200

...etc.

Following your method and wget'ting from a remote server seems to do 
a bit better (just watching vmstat since I can't compare timings against
my original method). wget seems to read 8K and write it in two 4K writes.
Don't know if this has anything to do with things... Pauses are still
there and the disc activity light still goes out several times per minute
coincident with the pauses.

--Adam

