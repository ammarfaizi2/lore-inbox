Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWAXDwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWAXDwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWAXDwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:52:13 -0500
Received: from ns2.suse.de ([195.135.220.15]:57525 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030292AbWAXDwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:52:11 -0500
From: Neil Brown <neilb@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Date: Tue, 24 Jan 2006 14:51:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.42076.633018.163881@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
In-Reply-To: message from Reuben Farrelly on Saturday January 21
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	<43D170CB.8080802@reub.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday January 21, reuben-lkml@reub.net wrote:
> md: stopping all md devices.
> md: md1 switched to read-only mode.
> BUG: unable to handle kernel NULL pointer dereference<6>md: md2 switched to 
> read-only mode.
>   at virtual address 0000001c
>   printing eip:
> b02a6951
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
> Modules linked in: iptable_mangle iptable_nat ip_nat ip_conntrack nfnetlink 
> iptable_filter ip_tables nfsd exportfs lockd sunrpc ipv6 ip_gre binfmt_misc 
> serio_raw piix hw_random
> CPU:    0
> EIP:    0060:[<b02a6951>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.16-rc1-mm2 #1)
> EIP is at bitmap_daemon_work+0x144/0x391

Hmmmm.... yep. I see the problem.  We shouldn't be tearing down the
bitmap when switching to read-only.  Patch to follow.

Thanks,

NeilBrown
