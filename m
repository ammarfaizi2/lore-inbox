Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRCDR0f>; Sun, 4 Mar 2001 12:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130469AbRCDR0Z>; Sun, 4 Mar 2001 12:26:25 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:35062 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130461AbRCDR0K>; Sun, 4 Mar 2001 12:26:10 -0500
Date: Sun, 4 Mar 2001 18:26:01 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Adam Sampson <azz@gnu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VM balancing problems under 2.4.2-ac1
Message-ID: <20010304182601.D27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.31.0102232120531.8568-100000@localhost.localdomain> <Pine.NEB.4.33.0103030053070.14582-100000@io.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.NEB.4.33.0103030053070.14582-100000@io.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Sat, Mar 03, 2001 at 01:03:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2001 at 01:03:26AM +0100, Adrian Bunk wrote:
> > If anybody as a good idea to make this code auto-balancing,
> > please let me know.
> 
> I have no idea for auto-balancing but another idea: It's one possibility
> to let the user choose when doing "make *config" what he wants:
> 
> - A VM optimized for servers that swaps out applications in favor of
>   caching.
> or
> - A VM optimized for workstations that won't swap out applications in
>   favor of caching.

I thought about the same thing sometimes (but for other troughput
vs. latency decisions, too).

But I realized, that my very own workstation is also a server,
since it runs an httpd, mysqld, smbd, ftpd etc.

And somtimes the servers become very busy in our LAN[1].

IF we want that tuning, we should have it as a sysctl. Most of it
is already possible with /proc/sys/vm/*, but balancing decisions
are still missing.

And even for servers we need to reduce caching sometimes. Think
of an httpd serving _very_ dynamic content. Or any other
application (e.g. DMBS), that doesn't rely on file system
caching.

A anonymous/file-backed[2] ratio would be VERY handy ;-)

But maybe this will be implemented one day along the lines of QoS
in the VM...

Regards

Ingo Oeser

[1] >1500 possible clients for these servers.
[2] Not counting swaps as file backed. We have a special inode
   for the swapper anyway, right?
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
