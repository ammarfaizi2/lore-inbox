Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUECSaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUECSaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUECSaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:30:11 -0400
Received: from palrel12.hp.com ([156.153.255.237]:59800 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263820AbUECSaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:30:06 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.36778.587011.400850@napali.hpl.hp.com>
Date: Mon, 3 May 2004 11:30:02 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de,
       eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <Pine.LNX.4.58.0405031109520.1589@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
	<16534.35355.671554.321611@napali.hpl.hp.com>
	<Pine.LNX.4.58.0405031109520.1589@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 3 May 2004 11:20:35 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> On Mon, 3 May 2004, David Mosberger wrote:

  >>  Why not just disallow user-level use of the _syscall() macros.

  Linus> I'm thinking we should disallow the system-calls
  Linus> entirely. User mode should be using their own macros, and
  Linus> kernel mode should just do the function call directly.

I totally agree.  (Note that syscall() is a libc-provided routine.
The kernel has nothing to do with it.)

  Linus> How much work would that be? I suspect it would be less work
  Linus> than worrying about the existing strange interfaces.

Yes.  On ia64, I held off on getting rid of kernel-internal syscalls
entirely because I was too lazy to do kernel_thread().  However, a
while ago, there was a bug that forced us to implement kernel_thread()
via a direct call.  Lo and behold, the resulting code was not only a
lot faster, but it turned out to be short and clean, too.  Very likely
the situation would be similar for the other architectures that have
been holding off on implementing the kernel syscalls via direct calls.

	--david
