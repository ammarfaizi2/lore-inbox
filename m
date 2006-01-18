Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWARPSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWARPSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWARPSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:18:24 -0500
Received: from colin.muc.de ([193.149.48.1]:33034 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030342AbWARPSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:18:24 -0500
Date: 18 Jan 2006 16:18:16 +0100
Date: Wed, 18 Jan 2006 16:18:16 +0100
From: Andi Kleen <ak@muc.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, tony.luck@intel.com
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Message-ID: <20060118151816.GA82365@muc.de>
References: <4370AF4A.76F0.0078.0@novell.com> <20060114045635.1462fb9e.akpm@osdl.org> <17358.11049.367188.552649@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17358.11049.367188.552649@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:48:57PM +1100, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > If you do a `make oldconfig' with CONFIG_DEBUG_KERNEL you get
> > -fasynchronous-unwind-tables and (on my yellowdog-4 toolchain at least) the
> > ppc64 kernel doesn't like that one bit. 
> > 
> > 
> > EXT3-fs: mounted filesystem with ordered data mode.
> > ADDRCONF(NETDEV_UP): eth0: link is not ready
> > tg3: eth0: Link is up at 100 Mbps, full duplex.
> > tg3: eth0: Flow control is off for TX and off for RX.
> > ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > autofs: Unknown ADD relocation: 44
> > sunrpc: Unknown ADD relocation: 44
> 
> We aren't handling R_PPC64_REL64 relocations in our module code.  This
> patch (completely untested :) might help.

The module loader should be discarding these sections on most architectures
because there is nothing that needs them and it's just a waste of memory
to store them.

[IA64 might be an exception because they have a kernel level unwinder]

So it would be best to change the module loader to do this I guess.

-Andi
