Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWCFLaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCFLaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWCFLaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:30:21 -0500
Received: from canuck.infradead.org ([205.233.218.70]:48588 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750866AbWCFLaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:30:20 -0500
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthew Grant <grantma@anathoth.gen.nz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <17420.7204.375377.273773@cargo.ozlabs.ibm.com>
References: <1141521960.7628.9.camel@localhost.localdomain>
	 <1141557862.3764.47.camel@pmac.infradead.org>
	 <1141633685.7634.13.camel@localhost.localdomain>
	 <20060306024512.4594b58d.akpm@osdl.org>
	 <17420.7204.375377.273773@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 11:30:02 +0000
Message-Id: <1141644602.4110.37.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 22:25 +1100, Paul Mackerras wrote:
> I have been looking at the equivalent code on powerpc.  This looks to
> me like we aren't calling do_signal on the way back out of the system
> call to userspace on x86 when the _TIF_RESTORE_SIGMASK thread_info
> flag is set.  I had a look at the code in arch/i386/kernel and I can't
> see why we wouldn't be getting to do_signal, but x86 assembly is not
> my strong point.

You can't see it because it's not in assembly -- it's in
do_notify_resume() in signal.c :)

> The fact that userspace is seeing the -ERESTARTNOHAND return value
> from the rt_sigsuspend strongly suggests that we aren't actually
> calling do_signal, though.

That's just because we do the ptrace stop _before_ do_signal now, just
as we already did for all other restartable syscalls. The signal really
is happening -- you can see the sigreturn().

-- 
dwmw2

