Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWB1Llm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWB1Llm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWB1Llm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:41:42 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:59592 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751520AbWB1Lll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:41:41 -0500
Date: Tue, 28 Feb 2006 12:41:32 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, garloff@suse.de
Subject: Re: Linux v2.6.16-rc5 - regression
Message-ID: <20060228114132.GA25749@brainysmurf.cs.umu.se>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060228093846.GA24867@brainysmurf.cs.umu.se> <20060228020336.79616850.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060228020336.79616850.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 02:03:36AM -0800, Andrew Morton wrote:
> Peter Hagervall <hager@cs.umu.se> wrote:
> >
> > In -rc5 the printk timing numbers do not reset to [    0.000000] upon
> >  boot.
> 
> What numbers are you getting now?
> 

[4294667.296000] and upwards.

> > This worked in -rc4 and so I started bisecting and git came up
> >  with:
> > 
> >  commit 9827b781f20828e5ceb911b879f268f78fe90815
> >  Author: Kurt Garloff <garloff@suse.de>
> >  Date:   Mon Feb 20 18:27:51 2006 -0800
> > 
> >  	[PATCH] OOM kill: children accounting
> > 
> >  I can't see why that would break the timing information, but I'll just
> >  assume that git was right, and tell you guys.
> 
> Well yes, it'll be something else - perhaps some TSC change or something. 
> We'd need to know what architecture you're using...

sap ~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1994.176
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3992.49

> 
> Anwyay, these numbers aren't supposed to measure anything absolute like
> uptime - they're purely for relative timing.  It would be nice to get them
> increasing monotonically from zero, but we wouldn't bust a gut to achieve
> that - it's just a debugging thing.

Yeah, it's not a showstopper or anything, just thought I'd pipe up.

	Peter Hagervall

-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
