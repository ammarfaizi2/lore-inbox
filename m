Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265269AbSJWWUH>; Wed, 23 Oct 2002 18:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSJWWUH>; Wed, 23 Oct 2002 18:20:07 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29200 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265269AbSJWWTi>;
	Wed, 23 Oct 2002 18:19:38 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210232225.g9NMPSr310610@saturn.cs.uml.edu>
Subject: Re: 2.5.44 io accounting weirdness, bi & bo swapped?
To: ahu@ds9a.nl (bert hubert)
Date: Wed, 23 Oct 2002 18:25:28 -0400 (EDT)
Cc: riel@conectiva.com.br, akpm@digeo.com, linux-kernel@vger.kernel.org,
       acahalan@cs.uml.edu
In-Reply-To: <20021023124819.GA32421@outpost.ds9a.nl> from "bert hubert" at Oct 23, 2002 02:48:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert writes:
> On Wed, Oct 23, 2002 at 02:13:47PM +0200, bert hubert wrote:

>> It appears as if the kernel does its accounting wrong in
>> some places. For example, with procps 3.0.4, dd if=/dev/zero
>> of=/mnt/100mb bs=1024 count=100000 causes large 'bi' readings:
>
> My bad. In this case, what I thought of as sane:
...
> Is not. Touching a page entails reading it. In Albert's procps
> with 2.5.44, bi and bo are reversed. Rik's vmstat does report
> things correctly.

That's fixed now. Rik's vmstat is not correct; according to his
documentation "bo" means "blocks in" and "bi" means "blocks out",
but that's not what his vmstat does. :-)

The only Linux vmstat that runs according to spec:

http://procps.sf.net/
http://procps.sf.net/procps-3.0.5.tar.gz

---------------- recent changes -----------------

procps-3.0.4 --> procps-3.0.5

top tolerates super-wide displays
better (?) RPM generation
XConsole and top.desktop removed
old build system removed
code cleanup
pgrep and pkill get "-o" (oldest matching process)
had vmstat "bi" and "bo" output interchanged on 2.5.xx
fix man page tbl directives
top man page cleaned up

procps-3.0.3 --> procps-3.0.4

make top go faster
Linux 2.2.xx ELF note warning removed
only show IO-wait on recent kernels
fix top's SMP stats
fix top for "dumb" and "vt510" terminals
in top, limit the priority values to -99 ... 99

procps-3.0.2 --> procps-3.0.3

more "make install" fixes
lib CFLAGS working again
top.1 codes fixed
bad (int*) cast in top removed
top runs faster
libproc memory corruption fixed
rant moved out of top.1 man page
ability to SKIP installing things
fixed ps --sort crash
