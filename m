Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCUFKc>; Thu, 21 Mar 2002 00:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCUFKW>; Thu, 21 Mar 2002 00:10:22 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19187
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293326AbSCUFKG>; Thu, 21 Mar 2002 00:10:06 -0500
Date: Wed, 20 Mar 2002 21:11:01 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        MrChuoi <MrChuoi@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020321051101.GA2673@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	MrChuoi <MrChuoi@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020319180417.GP2254@matchmail.com> <E16nOJF-0008Le-00@the-village.bc.nu> <20020319182933.GS2254@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:29:33AM -0800, Mike Fedyk wrote:
> On Tue, Mar 19, 2002 at 06:26:09PM +0000, Alan Cox wrote:
> > > Is there any way (I don't thing so, but...) that KDE can affect this when
> > > there aren't any KDE processes running?
> > 
> > Please try -ac2. It seems KDE just happens to be one of the triggers for
> > a bug where someone mremaps a partial vma larger and moves it.
> 
> OK, will do.
> 

Ok, did.

So far, after "up 1 day,  2:14" running a "while; make -j5" loop I haven't
seen my Committed_AS grow like before.

In multi user mode 116 processes running (with make -j loop):
        total:    used:    free:  shared: buffers:  cached:
Mem:  129703936 117108736 12595200        0  3862528 58535936
Swap: 500056064 70832128 429223936
MemTotal:       126664 kB
MemFree:         12300 kB
MemShared:           0 kB
Buffers:          3772 kB
Cached:          24416 kB
SwapCached:      32748 kB
Active:          78996 kB
Inact_dirty:     18796 kB
Inact_clean:      1912 kB
Inact_target:    19940 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126664 kB
LowFree:         12300 kB
SwapTotal:      488336 kB
SwapFree:       419164 kB
Committed_AS:   133840 kB

After:
        total:    used:    free:  shared: buffers:  cached:
Mem:  129703936 76472320 53231616        0  8724480 54001664
Swap: 500056064    40960 500015104
MemTotal:       126664 kB
MemFree:         51984 kB
MemShared:           0 kB
Buffers:          8520 kB
Cached:          52696 kB
SwapCached:         40 kB
Active:          40848 kB
Inact_dirty:     16264 kB
Inact_clean:      5852 kB
Inact_target:    12592 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126664 kB
LowFree:         51984 kB
SwapTotal:      488336 kB
SwapFree:       488296 kB
Committed_AS:     2228 kB
                  ^^^^
		  
		 This was down to ~500k before mutt was started.
		 
init-+-bdflush
     |-init---bash---bash-+-mutt---editor
     |                    `-pstree
     |-keventd
     |-kjournald
     |-ksoftirqd_CPU0
     |-kswapd
     |-kupdated
     |-lockd
     |-mdrecoveryd
     `-rpciod
