Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUDLWCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 18:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUDLWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 18:02:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:36316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263130AbUDLWCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 18:02:53 -0400
Date: Mon, 12 Apr 2004 15:02:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: fix must_not_trace_exec() test
Message-ID: <20040412150252.D21045@build.pdx.osdl.net>
References: <20040410200551.31866667.akpm@osdl.org> <878yh1y1gs.fsf@goat.bogus.local> <407AA51F.5020205@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <407AA51F.5020205@myrealbox.com>; from luto@myrealbox.com on Mon, Apr 12, 2004 at 07:18:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Olaf Dietsche wrote:
> > Although, I'd rather not lump together unrelated tests without
> > renaming must_not_trace_exec(). Btw, can someone enlighten me what
> > this atomic_read() test is all about.
> 
> I assumed that the test was to check if the caller is a thread, but that
> sounds odd -- wouldn't it stop being a thread after the exec anyway?
> Maybe that part happens after compute_creds, so this prevents a race?
> Although I don't see how it could be triggered if the thread never
> entered usermode before getting a new fs/files/sighand.

There's no requirement for CLONE_THREAD when using at least CLONE_FS
and CLONE_FILES.  And all of the latter are inherited across execve().
These tests are needed to keep a malicious program from controlling the
setuid program in ways other than ptrace.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
