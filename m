Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUFEVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUFEVsS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFEVsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:48:18 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19905 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262062AbUFEVsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:48:03 -0400
Subject: Re: clone() <-> getpid() bug in 2.6?
From: Robert Love <rml@ximian.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406051405110.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	 <20040605205547.GD20716@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0406051405110.7010@ppc970.osdl.org>
Content-Type: text/plain
Date: Sat, 05 Jun 2004 17:48:02 -0400
Message-Id: <1086472082.7940.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 14:13 -0700, Linus Torvalds wrote:

> Uli, if Arjan is right, then please fix this. It's a buggy and pointless 
> optimization. Anybody who optimizes purely for benchmarks should be 
> ashamed of themselves.

Eh, it definitely does, in nptl/sysdeps/unix/sysv/linux/getpid.c:

	pid_t result = THREAD_GETMEM (THREAD_SELF, pid);
	if (__builtin_expect (result <= 0, 0))
	  result = really_getpid (result);

A few places, including the fork code, fix it:

	/* Adjust the PID field for the new process.  */
	THREAD_SETMEM (self, pid, THREAD_GETMEM (self, tid));

But not direct calls to clone(2).

	Robert Love


