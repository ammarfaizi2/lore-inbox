Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUDBW4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUDBW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:56:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52640
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261262AbUDBW4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:56:40 -0500
Date: Sat, 3 Apr 2004 00:56:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402225636.GX21341@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040402133540.1dfa0256.akpm@osdl.org> <20040402143639.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402143639.G21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:36:39PM -0800, Chris Wright wrote:
> [..] I think basically
> nobody really uses capabilites except in either simple root drops a
> few privs ways (no exec), [..]

yep, at least sendmail does that (I remeber because there was a kernel
bug at some point not dropping those).

If I understand well, the basic problem is that there's no way to retain
a single capability forever through execve and everything else possible.
We'd need a way to tell the kernel a certain capability must never go
away no matter what syscall is being run. Of course one will need need a
special capability to use this functionality (CAP_ADMIN or similar) and
login/su will then be able to give IPC_CAP_LOCK to an user. I think
at some point there was something like this being discussed, when there
were still discussions about putting the capabilities into the fs (or
the elf header or whatever).
