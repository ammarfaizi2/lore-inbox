Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUKCXfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUKCXfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKCXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:33:04 -0500
Received: from aun.it.uu.se ([130.238.12.36]:59297 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262002AbUKCX2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:28:11 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16777.27011.538359.877780@alkaid.it.uu.se>
Date: Thu, 4 Nov 2004 00:28:03 +0100
To: linux-kernel@vger.kernel.org
Subject: send_sig_info() from switch_to()?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to do the equivalent of send_sig_info()
to current from within switch_to()? My attempts to do
so have all lead to hard kernel hangs, so I guess not,
but I though I'd ask anyway.

There is a HW-issue with delayed interrupts from performance
counter overflows on x86 and x86-64, which, if not handled,
can result in a interrupt being delivered to the wrong task.
(It's only been observed with certain high-rate events.)
I can work around this in the perfctr kernel extension by
masking the interrupt early in switch_to()'s suspend path
and manually detecting if any counters have overflowed.
Normal HW-detected overflows are routed to user-space via a
send_sig_info() in the interrupt handler. The problem is that
calling send_sig_info() from within switch_to() to signal
SW-detected overflows seems to cause kernel hangs. (I've tried
it both in the suspend path and in the resume path.)

Any ideas?

/Mikael
