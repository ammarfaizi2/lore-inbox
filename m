Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTAGWhS>; Tue, 7 Jan 2003 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTAGWhR>; Tue, 7 Jan 2003 17:37:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267536AbTAGWhO>;
	Tue, 7 Jan 2003 17:37:14 -0500
Subject: Re: [PATCH] kexec for 2.5.54
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <m1fzs6j0bh.fsf_-_@frodo.biederman.org>
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>
	<20030103181100.A10924@in.ibm.com>  <m1fzs6j0bh.fsf_-_@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jan 2003 14:46:00 -0800
Message-Id: <1041979560.12674.93.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 21:48, Eric W. Biederman wrote:
> 
> O.k.  I have switched to using the init_mm and premapping the reboot
> code buffer.
<snip>
> The code in machine_kexec now takes no locks and is drop dead simple,
> so it should be safe to call from a panic handler.  

Eric,

The patch applies cleanly to 2.5.54 for me.  Current behavior matches
the version of kexec for 2.5.48 that I carried forward into 2.5.52 and
2.5.54 (and kexec_tools 1.8): 

- the kexec-ed kernel starts rebooting and finds all of my system's
memory, so the generic kexec machinery is working as expected.

- the kexec-ed kernel hangs while calibrating the delay loop.  The list
of kernels I attempted to reboot includes permutations of 2.5.48 +/-
kexec, 2.5.52 +/- kexec(from 2.5.48), 2.5.54, 2.5.54 + kexec(from
2.5.48), and 2.5.54 + kexec (recent patch from you).

- Whatever it is that SuSE supplies in 8.0 (2.4.x +) panics near/during
frame buffer initialization when rebooted via kexec for 2.5.54:
	.
	.
	.
	Initializing CPU#0
	Detected 799.665 MHz Processor
	Console: colour VGA+ 80x25
	invalid operand: 0000
	CPU: 0
	EIP: 0010[<00000007>] Not tainted
	EFLAGS 00010002
	.
	.
	.

Something has definitely changed in the 2.5.5x series, and the symptoms
indicate that at least the clock interrupt is not being received.

kexec for 2.5.48 worked for me (with some limits), so I should be able
to walk the tree forwards and poke at it some more.

For those that have had success w/ recent vintage kernels and kexec (>
2.5.48), could I get a roll-call of your machine's hardware?  Uniproc,
SMP, AGP, chipset, BIOS version, that kind of thing.  lspci -v,
/cat/proc/cpuinfo, and maybe the boot-up messages would all be
appreciated.

Regards,
Andy


