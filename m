Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUHLB2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUHLB2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUHLB16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:27:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:49133 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268404AbUHKXmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:42:46 -0400
Date: Wed, 11 Aug 2004 16:42:45 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811234245.GA7721@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040811224117.GA6450@plexity.net> <20040811231314.GA32106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811231314.GA32106@redhat.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12 2004, at 00:13, Dave Jones was caught saying:
> On Wed, Aug 11, 2004 at 03:41:17PM -0700, Deepak Saxena wrote:
> 
>  > - Do we want to standardize on a set of attributes that all CPUs
>  >   must provide to sysfs? bogomips, L1 cache size/type/sets/assoc (when
>  >   available), L2 cache (L3..L4), etc?
> 
> For x86 at least, this can be entirely decoded in userspace using
> the /dev/cpu/x/cpuid interface. See x86info for example of this.
> 
>  > - Instead of dumping the "flags" field, should we just dump cpu
>  >   registers as hex strings and let the user decode (as the comment
>  >   for the x86_cap_flags implies.
> 
> ditto.

OK, just saw that code now and my reponse is to remove that 
interface in the long-term and move cpuid into sysfs (and not 
export all the cache info separately). In theory we don't even 
need the xxx_bug fields as those can be determined from looking
at CPU binary data.

> As these require arch specific parsers anyway, I don't think it makes
> too much sense making a kernel abstraction trying to make them all
> look 'the same', and if it can be done in userspace, why bother ?

If it is all done in userspace, then just having the raw binary
data available via sysfs w/o kernel parsing is probably best. The
question I have is are there any cross-platform userland tools/apps
that just want to know things like cache-size w/o worrying about
CPU specifics? Even if they do, I suppose they can be fixed to read
that information from a binary blob and parse it dependent on 
the arch. ARM (other arch I really care about) could just output 
all the various ID registers into a binary blob and I am sure the
same can be done for the other arches.

> The only other concern I have is the further expansion of sysfs with
> no particular gain over what we currently have. The sysfs variant
> *will* use more unreclaimable RAM than the proc version.

Agreed, but that hasn't kept other data such as PCI and partition 
information from moving into sysfs.

> /proc/cpuinfo has done well enough for us for quite a number of years
> now, what makes it so urgent to kill it now that sysfs is the
> virtual-fs-de-jour ?

Consitency in userspace interface. My understanding is that goal is to 
make /proc slowly return to it's original purpose (process-information) 
and move other data out into sysfs.  

~Deepak


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
