Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTLUVLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLUVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:11:04 -0500
Received: from ping.ovh.net ([213.186.33.13]:34989 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S264127AbTLUVLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:11:00 -0500
Date: Sun, 21 Dec 2003 22:09:17 +0100
From: Octave <oles@ovh.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221210917.GB4897@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312211832320.6632@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a kernel panic, its the VM debugging output.
> 
> Can you please apply the attached patch on top of 2.4.23 and rerun the
> test with "echo 1 > /proc/sys/vm_gfp_debug" ?
> 
> It will printout the number of available swap pages when processes get
> killed.

Marcelo,

How about this ?

Dec 21 22:08:44 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 21 22:08:44 stock kernel: OOM: nr_swap_pages=0cd865e6c c012e1e8 c0262e3c 00000000 000001d2 00000000 00000001 cd863c00 
Dec 21 22:08:44 stock kernel:        0000040e 00000000 00000018 00000002 c029e9d8 c029ead4 00000000 000001d2 
Dec 21 22:08:44 stock kernel:        00000000 c012dd80 c11d3db0 c0121fe8 e0b12220 bffffb20 00000001 cd863c00 
Dec 21 22:08:44 stock kernel: Call Trace:    [__get_free_pages+4/24] [_alloc_pages+24/28] [do_wp_page+168/736] [handle_mm_fault+135/184] [do_page_fault+395/1229]
Dec 21 22:08:44 stock kernel: Call Trace:    [<c012e1e8>] [<c012dd80>] [<c0121fe8>] [<c0122913>] [<c0111707>]
Dec 21 22:08:44 stock kernel:   [do_page_fault+0/1229] [error_code+52/60]
Dec 21 22:08:44 stock kernel:   [<c011157c>] [<c0106fa0>]
Dec 21 22:08:44 stock kernel: VM: killing process watchdog
Dec 21 22:08:44 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 21 22:08:44 stock kernel: OOM: nr_swap_pages=0f7767e6c c012e1e8 c0262e3c 00000000 000001d2 00000000 00000001 f79bf6e0 
Dec 21 22:08:44 stock kernel:        0000040e 00000000 00000018 00000002 c029e9d8 c029ead4 00000000 000001d2 
Dec 21 22:08:44 stock kernel:        00000000 c012dd80 c11d3db0 c0121fe8 f7be36c0 bffffb20 00000001 f79bf6e0 
Dec 21 22:08:44 stock kernel: Call Trace:    [__get_free_pages+4/24] [_alloc_pages+24/28] [do_wp_page+168/736] [_alloc_pages+24/28] [handle_mm_fault+135/184]
Dec 21 22:08:44 stock kernel: Call Trace:    [<c012e1e8>] [<c012dd80>] [<c0121fe8>] [<c012dd80>] [<c0122913>]
Dec 21 22:08:45 stock kernel:   [do_page_fault+395/1229] [do_page_fault+0/1229] [do_fork+1719/2028] [sys_fork+20/28] [error_code+52/60]
Dec 21 22:08:45 stock kernel:   [<c0111707>] [<c011157c>] [<c01150eb>] [<c0105a44>] [<c0106fa0>]
Dec 21 22:08:45 stock kernel: VM: killing process watchdog

Octave
