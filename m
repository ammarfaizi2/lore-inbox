Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbTGDXMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbTGDXMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:12:14 -0400
Received: from dp.samba.org ([66.70.73.150]:11223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266202AbTGDXMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 19:12:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16134.3376.132454.633616@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jul 2003 09:26:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org,
       anton@au.ibm.com, engebret@us.ibm.com
Subject: Re: [PATCH 2.5.73] Signal handling fix for ppc
In-Reply-To: <20030704175859.GF22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de>
	<20030704174339.GB22152@wohnheim.fh-wedel.de>
	<20030704174558.GC22152@wohnheim.fh-wedel.de>
	<20030704175439.GE22152@wohnheim.fh-wedel.de>
	<20030704175859.GF22152@wohnheim.fh-wedel.de>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> This patch causes an application with a broken stack to die with a
> SIGSEGV (and a core dump and all that) instead of a silent do_exit.
> 
> Most other architectures already have it, so ppc should get it as
> well.

OK.  The changes are OK in principle but your patch is a bit borken
since you add a check "if (sig == SIGSEGV)" in sys_sigreturn and
sys_rt_sigreturn, but there is no variable called "sig" in those
functions.

I have some other signal changes pending.  I'll roll in your changes
and push it on to Linus shortly.

Paul.
