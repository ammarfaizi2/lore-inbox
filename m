Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUA0Wvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUA0Wvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:51:35 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:19131 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263310AbUA0Wvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:51:33 -0500
Date: Tue, 27 Jan 2004 10:18:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Johnson <davejohnson_hifi@yahoo.com>
Cc: cort@fsmlabs.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: Using 8 Instruction and Data BAT registers in 82xx
Message-ID: <20040127171858.GG32525@stop.crashing.org>
References: <20040126182941.50687.qmail@web21405.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126182941.50687.qmail@web21405.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 10:29:41AM -0800, Dave Johnson wrote:
> 
> Hi All:
> As there are 8 data and Instruction BAT registers in
> some 82xx flavors, and Cort has posted a patch to ADD
> these registers
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0209.1/0871.html)
> I was wondering if anyone has any idea how to use
> these addistional BAT regs be used?? Perhaps for new
> processes and threads, etc.

Step one would be to audit the usages of the 8_BATS feature to ensure
that they'll be fine if invoked on an 82xx with 8 BATS.  It's almost
certainly going to be true, but should still be done.

Step two would be to distinguish the 82xx's with 8 BATs from the ones
that don't.  I don't know if these have a different PVR, but I hope they
do, otherwise it'll be harder (but not impossible certainly) to.

Finally, as you've probably surmised, all that we do with these
additional BATs is to clear them out.  It could be possible to extend
io_block_mapping to make use of these additional BATs (and
v_mapped_by_bats/p_mapped_by_bats, etc).

Trying to do processes and/or threads (i.e. userland stuff) becomes a
giant pain (per-context BAT mappings have to be tracked), there's lots
of security implications to keep in mind, and of course the overhead of
doing all of this will probably cancel out any speed gain you would have
otherwise gotten.

-- 
Tom Rini
http://gate.crashing.org/~trini/
