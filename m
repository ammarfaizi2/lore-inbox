Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTKZAzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbTKZAzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:55:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:31206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263806AbTKZAzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:55:02 -0500
Date: Tue, 25 Nov 2003 16:55:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: can't lockf() over NFS
Message-ID: <20031125165501.A20302@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>; from mb/lkml@dcs.qmul.ac.uk on Tue, Nov 25, 2003 at 04:17:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Bernstein (mb/lkml@dcs.qmul.ac.uk) wrote:
> I can't get Debian testing to log in to GNOME when home directories are
> mounted over NFS (Linux 2.6 client -> Linux 2.4-ac server). It claims not
> to be able to lock a file..
> 
> I tried writing a trivial program to test lockf() and it returns ENOLCK 
> over NFS, but succeeds locally. The client kernel offers some grumbles:
> 
> RPC: Can't bind to reserved port (13).
> RPC: can't bind to reserved port.
> nsm_mon_unmon: rpc failed, status=-5
> lockd: cannot monitor a.b.c.d
> lockd: failed to monitor a.b.c.d
> 
> [where a.b.c.d is our NFS server]
> 
> /sbin/rpc.statd is running on both client and server, and with a 2.4
> kernel on the client (as the only change) GNOME logins and the lockf()  
> test program work just fine.
> 
> Any ideas? I'm stumped at this point.

Yes, can you either change your config to:

CONFIG_SECURITY=n

or:

CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y

or:

CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=m
and modprobe capability

Thanks, this had fallen off my radar.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
