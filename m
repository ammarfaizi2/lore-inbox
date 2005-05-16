Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVEPWfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEPWfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEPWf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:35:27 -0400
Received: from dvhart.com ([64.146.134.43]:1954 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261278AbVEPWeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:34:19 -0400
Date: Mon, 16 May 2005 15:34:15 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI
Message-ID: <768860000.1116282855@flay>
In-Reply-To: <42822B5F.8040901@sw.ru>
References: <42822B5F.8040901@sw.ru>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, May 11, 2005 19:57:19 +0400 Kirill Korotaev <dev@sw.ru> wrote:

> against 2.6.12-rc4
> 
> This patch adds dumping of calltraces on _all_ CPUs
> on AltSysRq-P and NMI LOCKUP. It does this via sending
> NMI IPI interrupts to the cpus.
> 
> I saw the same patch in RedHat kernels, here goes our own version of the patch, not sure it will be accepted, but I think it can be used by some people at least for debugging lockups etc.

I'd done a similar thing, but just using smp_call_function (I hacked the
interrupt routine to fish pt_regs back out, and override *info in some
cases). Doing NMIs, as you've done, is probably nicer, but a lot more
work.

The problem with it (and my patch too) is that you're hooking into arch
specific code from generic code, which means you'll break every other
arch apart from i386. Fixing this is a pain in the rear end, but would
be needed to merge the patch. OTOH, the patch is extremely useful, so
would be nice to fix if you have the energy ...

M.


