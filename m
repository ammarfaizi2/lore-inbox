Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTLUWXt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTLUWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:23:48 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11527 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264162AbTLUWXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:23:47 -0500
Date: Sun, 21 Dec 2003 23:23:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Octave <oles@ovh.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221222338.GC1323@alpha.home.local>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet> <20031221210917.GB4897@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221210917.GB4897@ovh.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 10:09:17PM +0100, Octave wrote:
> > This is not a kernel panic, its the VM debugging output.
> > 
> > Can you please apply the attached patch on top of 2.4.23 and rerun the
> > test with "echo 1 > /proc/sys/vm_gfp_debug" ?
> > 
> > It will printout the number of available swap pages when processes get
> > killed.
> 
> Marcelo,
> 
> How about this ?
> 
> Dec 21 22:08:44 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> Dec 21 22:08:44 stock kernel: OOM: nr_swap_pages=0cd865e6c c012e1e8 c0262e3c 00000000 000001d2 00000000 00000001 cd863c00 

OK, so there's no available swap anymore (nr_swap_pages=0, Marcelo forgot the
'\n' in the patch). I simply think that with other kernels, you're very short
of memory, but it runs, while with this one, all memory gets consumed, and
since there's no smart oom killer, one process has to get killed.

Cheers,
Willy

