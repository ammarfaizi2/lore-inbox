Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUGLNoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUGLNoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266828AbUGLNoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:44:17 -0400
Received: from gerf.org ([204.42.16.60]:18137 "EHLO gerf.org")
	by vger.kernel.org with ESMTP id S266832AbUGLNoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:44:11 -0400
Date: Mon, 12 Jul 2004 08:44:07 -0500
From: The Doctor What <docwhat@gerf.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 - Oops when unsuspending on PPC iBook
Message-ID: <20040712134407.GA27486@gerf.org>
Mail-Followup-To: The Doctor What <docwhat@gerf.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20040709233608.GC21865@gerf.org> <1089595978.1876.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089595978.1876.12.camel@gaston>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.4.18-1-686 (i686)
X-GPG-Key: http://docwhat.gerf.org/gpg.key
X-GPG-Fingerprint: 23BC 0F41 9DB5 A70B B43C  3BE1 9090 E4B3 720D 3195
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt (benh@kernel.crashing.org) [040711 20:32]:
> On Fri, 2004-07-09 at 18:36, The Doctor What wrote:
> > See the attached config and oops.  I didn't think I had i2c compiled
> > in, but I guess I do. :-/
> > 
> > It's a stock 2.6.7 kernel except for the orinoco/hermes/airport
> > drivers.  I can test this without them, if someone really thinks
> > that that is the problem.
> > 
> > Any thoughts?  I'm having a problem getting my iBook (blueberry
> > 300Mhz iBook1) to suspend correctly (the display light doesn't go
> > off).  This use to work.  I'd prefer not to go back to 2.4...
> 
> The ooops backtrace isn't very readable... Do you use Alsa or
> dmasound ? It could be an alsa problem...

Yes, I use ALSA, which is compiled into the kernel.  If it is alsa, how would I go about tracing the problem.

------------8<------------->8------------
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ALSA device list:
   #0: PowerMac DACA (Dev 6) Sub-frame 0
------------8<------------->8------------

Here is another oops straight from my system's logs.  This one isn't
pbbuttonsd, but is alsamixer.  Would compling ALSA as modules help? I could
then unload them when suspending...
------------8<------------->8------------
Jul  9 20:23:55 localhost kernel: Oops: kernel access of bad area, sig: 11 [#2]
Jul  9 20:23:55 localhost kernel: PREEMPT 
Jul  9 20:23:55 localhost kernel: NIP: C01B8AE0 LR: C02016AC SP: C72F1E70 REGS: c72f1dc0 TRAP: 0300    Not tainted
Jul  9 20:23:55 localhost kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jul  9 20:23:55 localhost kernel: DAR: 00000006, DSISR: 40000000
Jul  9 20:23:55 localhost kernel: TASK = c4d959c0[4650] 'alsamixer' THREAD: c72f0000Last syscall: 54 
Jul  9 20:23:55 localhost kernel: GPR00: C02016AC C72F1E70 C4D959C0 00000000 00000003 00000004 00000000 00000003 
Jul  9 20:23:55 localhost kernel: GPR08: 00000002 00000001 D3BF9BBC 00000004 240004A4 10020D38 00000012 100A0000 
Jul  9 20:23:55 localhost kernel: GPR16: 00000000 1009475C 00000000 10090000 00000000 10020000 00000000 10020000 
Jul  9 20:23:55 localhost kernel: GPR24: D3FFACC4 D3FD0E00 00000000 FFFFFFF3 7FFFECB0 C0201638 C4156000 00000001 
Jul  9 20:23:55 localhost kernel: NIP [c01b8ae0] i2c_smbus_write_byte_data+0x1c/0x4c
Jul  9 20:23:55 localhost kernel: LR [c02016ac] daca_put_amp+0x74/0x8c
Jul  9 20:23:55 localhost kernel: Call trace:
Jul  9 20:23:56 localhost kernel:  [c02016ac] daca_put_amp+0x74/0x8c
Jul  9 20:23:56 localhost kernel:  [c01c9ce8] snd_ctl_elem_write+0x26c/0x2bc
Jul  9 20:23:56 localhost kernel:  [c0073bb8] sys_ioctl+0x140/0x358
Jul  9 20:23:56 localhost kernel:  [c0007880] ret_from_syscall+0x0/0x44
------------8<------------->8------------

Does that help?

Ciao!

-- 
	Operi Manos Laven. - Workers must wash hands.

The Doctor What: <fill in the blank>             http://docwhat.gerf.org/
docwhat *at* gerf *dot* org                                        KF6VNC
