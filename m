Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSLQR3l>; Tue, 17 Dec 2002 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLQR3l>; Tue, 17 Dec 2002 12:29:41 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38355 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265190AbSLQR3k>;
	Tue, 17 Dec 2002 12:29:40 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15871.24785.792097.896169@harpo.it.uu.se>
Date: Tue, 17 Dec 2002 18:37:21 +0100
To: root@chaos.analogic.com
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.3.95.1021217121612.25972B-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021217120925.25972A-100000@chaos.analogic.com>
	<Pine.LNX.3.95.1021217121612.25972B-100000@chaos.analogic.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
 > Actually I should be:
 > 
 > 	pushl	$next_address	# Where to go when the call returns
 > 	pushl	$0xfffff000	# Put this on the stack
 > 	ret			# 'Return' to it (jump)
 > next_address:			# Were we end up after

You just killed that process' performance by causing the
return-stack branch prediction buffer to go out of sync.

It might have worked ok on a 486, but P6+ don't like it one bit.

This is also why I'm slightly unhappy about the
s/int $0x80/call <address of sysenter>/ approach, since it leads
to yet another recursion level and risk overflowing the RSB.
