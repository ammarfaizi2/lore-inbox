Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288281AbSACSrL>; Thu, 3 Jan 2002 13:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288287AbSACSq7>; Thu, 3 Jan 2002 13:46:59 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:55530 "HELO
	dardhal") by vger.kernel.org with SMTP id <S288281AbSACSqS>;
	Thu, 3 Jan 2002 13:46:18 -0500
Date: Thu, 3 Jan 2002 19:46:10 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug in shrink_caches()
Message-ID: <20020103184609.GA3890@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200201030538.g035ceM31957@mysql.sashanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200201030538.g035ceM31957@mysql.sashanet.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 02 January 2002, at 22:38:40 -0700,
Sasha Pachev wrote:

> I am quite sure there is still a bug in shrink_caches(), at least there was 
> one in 2.4.17-rc2. I have not tried later releases, but there is nothing in 
> the changelog about the fixes anywhere near that area of the code, so I have 
> to assume the problem is still there.
> [...]
> When we get to the point where free memory starts running low, even though we 
> may have something like 100 MB of cache, shrink_caches() fails to free up 
> enough memory, which triggers the evil oom killer. Obviously, in the above 
> situation the correct behaviour is to go on cache diet before considering the 
> murders.
> 
I can confirm this behaviour in my own machine. 128 MB of RAM, swap
space turned off, machine running KDE 2.2.x, Konqueror, rxvt's, gkrellm,
xmms and some daemons, and mighty Mozilla :). At this point there are
still a couple of MB free, a couple buffered and aproximately 40 MB
in caches.

Trying to load OpenOffice641 the kernel feels it's OOM time, and kills
something, usually Mozilla (as it should). However, "watch cat
/proc/meminfo" reports about 30 MB in caches when OOM kicks in. Any
attempt to "tune" parameters under "/proc/sys/vm/" changes nothing.
Attempted changes include:
echo "0 0" > /proc/sys/vm/pagetable_cache

All this is with plain 2.4.17, no patches applied. Another thing I have
observed is caches growing "too" much, but this is more of a subjective
feeling than anything else.

Maybe unrelated, maybe not, is the fact that in 2.4.17 I still see short
"freezes" in interactive response after doing intensive disk access
(untarring something, finishing some dd'ing, rebuilding Debian package
database, etc.). Both on medium-end hardware (128 MB RAM, PIII 600) and
low-end hardware (64 MB RAM, P166). Vanilla 2.4.17 on both, with ext2 as
the only filesystem used in mounted partitions.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

