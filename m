Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUECU46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUECU46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbUECU46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:56:58 -0400
Received: from palrel13.hp.com ([156.153.255.238]:47537 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263991AbUECU4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:56:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.45589.62353.878714@napali.hpl.hp.com>
Date: Mon, 3 May 2004 13:56:53 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
	<16534.35355.671554.321611@napali.hpl.hp.com>
	<Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 3 May 2004 13:42:54 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> Rule: every architecture needs to implement its own kernel
  Linus> "execve()" function some way. Everything else is done by the
  Linus> architecture-independent <linux/unistd.h> translation layer.

Looks good to me.

  Linus> The only change here is that this makes "open()" and friends
  Linus> depend on the "sys_open()" and friends EXPORT's for
  Linus> modules. Right now it appears that
  Linus> sys_open/sys_lseek/sys_read are all EXPORT_SYMBOL_GPL's. That
  Linus> sounds pretty insane anyway (it's not like we can claim that
  Linus> "sys_open()" is some _internal_ interface), so I'd be
  Linus> inclined to just change them all to regular EXPORT_SYMBOL's.

Does the rule have to be that all sys_FOO() entry-points must be
exported via EXPORT_SYMBOL()?  Otherwise we have the strange issue
where a kernel-module may not be able to (easily) invoke a system call
which it could formerly invoke via _syscallN().  For example, the ATI
driver wants to call mlock()/munlock().  While this happens to be a
proprietary/binary-only driver, the same issue can arise with GPL'd
modules.

  Linus> Comments? To me, this is a pretty clear cleanup (and I left
  Linus> the old _syscallX() crud alone, even though we could remove
  Linus> it now entirely).

In my opinion, it would be good to remove _syscallX() altogether.

	--david
