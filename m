Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTJML3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTJML3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:29:16 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:60562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261664AbTJML3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:29:15 -0400
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031013120843.E19601@flint.arm.linux.org.uk>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	 <20031013040219.6ad71a57.akpm@osdl.org>
	 <20031013120843.E19601@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1066044551.24015.455.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 13 Oct 2003 12:29:12 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 12:08 +0100, Russell King wrote:
> jffs2 is using signal handlers as a method of communicating from user
> space to kernel space.  Maybe it should create some sysfs files.
> However, since there aren't any existing sysfs entities for jffs2 to
> attach these files to, this wouldn't seem to be reasonable.

To clarify -- the JFFS2 garbage collect thread is using SIGSTOP, SIGCONT
and SIGKILL from userspace to mean exactly what SIGSTOP, SIGCONT and
SIGKILL always mean in userspace.

Since it already has signal handling code, we also use SIGHUP for
wakeup, and userspace can send that too to trigger a single GC pass.

-- 
dwmw2

