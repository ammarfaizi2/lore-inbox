Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311057AbSCHT0T>; Fri, 8 Mar 2002 14:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311044AbSCHT0K>; Fri, 8 Mar 2002 14:26:10 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52720
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311051AbSCHTZz>; Fri, 8 Mar 2002 14:25:55 -0500
Date: Fri, 8 Mar 2002 11:26:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020308192643.GA29073@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020308022751.GF28141@matchmail.com> <E16jKJX-00069s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16jKJX-00069s-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 01:21:39PM +0000, Alan Cox wrote:
> > Won't this show up in rss or some other ps mem listing -or- is this
> > something that hasn't been exported to user space before on linux?
> 
> It might show up in /proc/<pid>/* - the maps list will show address
> spaces. Otherwise address space leaks have always been invisible and its
> only when you leak to 3Gb of unused address space the app will notice if
> its never touching it
> 

I couldn't find any processes that looked to use a lot of address space, so
I switched to single user mode (kills most everything...) and ran pstree and
/proc/memstat:

init-+-bdflush
     |-init---bash---pstree
     |-keventd
     |-kjournald
     |-ksoftirqd_CPU0
     |-kswapd
     |-kupdated
     |-lockd
     |-mdrecoveryd
     `-rpciod
        total:    used:    free:  shared: buffers:  cached:
Mem:  129662976 110067712 19595264        0 11984896 78237696
Swap: 500056064    40960 500015104
MemTotal:       126624 kB
MemFree:         19136 kB
MemShared:           0 kB
Buffers:         11704 kB
Cached:          76364 kB
SwapCached:         40 kB
Active:          62440 kB
Inact_dirty:      9568 kB
Inact_clean:     16780 kB
Inact_target:    17756 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126624 kB
LowFree:         19136 kB
SwapTotal:      488336 kB
SwapFree:       488296 kB
Committed AS:   355580 kB

I'll test without preempt and see if it shows up again.  It took a day
before though, so...
