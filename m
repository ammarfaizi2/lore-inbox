Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263803AbUECSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUECSHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUECSHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:07:54 -0400
Received: from palrel10.hp.com ([156.153.255.245]:33771 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263803AbUECSHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:07:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.35355.671554.321611@napali.hpl.hp.com>
Date: Mon, 3 May 2004 11:06:19 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040501175134.243b389c.akpm@osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 1 May 2004 17:51:34 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> It wasn't quite that simple - lots of architectures have
  Andrew> been inventive.

  Andrew> For 2.6.6 we should just stick that errno decl back in
  Andrew> there..

Why not just disallow user-level use of the _syscall() macros.
syscall() is a much more portable and easier to implement alternative
which has been around "forever" (even SunOS supported it, IIRC).  I
suppose there is a slight performance loss (function-call vs.  inline)
but we're talking about system calls here...

Also, the _syscall() macros have never been supported at the
user-level on ia64 linux and most packages already know to use
syscall().  Unfortunately, some "clever" maintainers use syscall()
only inside #ifdef __ia64, but that would be easy to fix if _syscall()
gets discouraged on all linux platforms.

	--david
