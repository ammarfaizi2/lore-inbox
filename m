Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268371AbUHLCqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268371AbUHLCqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268373AbUHLCqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:46:31 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6566 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268371AbUHLCpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:45:55 -0400
Date: Wed, 11 Aug 2004 19:45:54 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040812024554.GA20792@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040811224117.GA6450@plexity.net> <20040811231314.GA32106@redhat.com> <20040811234245.GA7721@plexity.net> <20040811235929.GB32468@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811235929.GB32468@redhat.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12 2004, at 00:59, Dave Jones was caught saying:
> 
> but why? it's totally pointless when the same info can be obtained
> from userspace without the bloat.
> 
<snip>
> 
> the raw binary is already available. in /dev/cpu/x/cpuid
> I repeat, duplicating this in sysfs is utterly pointless other than
> to bloat the kernels runtime memory usage.

I won't argue that there is no increase in memory usage. Looking at 
.text + .data for (i386/kernel/cpuid.c + i386/kernel/cpu/proc.c), there 
is a 2x increase (~1K -> ~2K) in size. I haven't looked at the runtime
memory required for extra the sysfs objects atm; however, given that sysfs 
is going to be used in just about every system out there (even small 
embedded devices), that size is probably negligble compared to the memory 
requirements for all the other users of sysfs. If we can look at
what really needs to be exported as a separate object and what
can be determined by userspace via parsing of binary blob, that
size diference will probably shrink considerably. 

>  > > /proc/cpuinfo has done well enough for us for quite a number of years
>  > > now, what makes it so urgent to kill it now that sysfs is the
>  > > virtual-fs-de-jour ?
>  > 
>  > Consitency in userspace interface.
> 
> sorry, but I think that argument is total crap.  Any userspace tool needing
> this info will still need to support the /dev/cpu/ interfaces if they want to
> also run on 2.2 / 2.4 kernels.  Likewise, anything using /proc/cpuinfo.
> Ripping this out does nothing useful that I see other than cause headache
> for userspace by having yet another interface to support.

In my original email I specifically said that we cannot remove /proc/cpuinfo 
today b/c of application requirements, but this is something for down
the road. The arbitrary date I choose (+1 year) can just as easilly be
+2 years to provide more time for apps to change over. Right now
there are 2 interfaces for cpu information via /proc/cpuinfo and /dev/cpu.
By moving to sysfs we can have 1 interface. That in itself seems like a
clear win.

>  > My understanding is that goal is to 
>  > make /proc slowly return to it's original purpose (process-information) 
>  > and move other data out into sysfs.  
> 
> I don't think thats a realistic goal. It'll take years just to migrate the
> in-kernel stuff, and there's god alone knows how much out-of-tree code doing
> the same, plus the add-ons from various vendor kernels etc so I doubt it'll
> ever be the process-only utopia you envision.

Nothing wrong with taking time. I never said we need to get rid of
stuff overnight. We can keep old interfaces around (see /proc/pci
for example) as long as it takes for core apps and kernel stuff
to switch over.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
