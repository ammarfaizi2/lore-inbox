Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbUDNAQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDNAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:16:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:59048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263678AbUDNAQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:16:34 -0400
Date: Tue, 13 Apr 2004 17:16:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Fabian Frederick <Fabian.Frederick@skynet.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-ID: <20040413171632.P22989@build.pdx.osdl.net>
References: <1081881778.5585.16.camel@bluerhyme.real3> <20040413170309.14b7a334.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040413170309.14b7a334.akpm@osdl.org>; from akpm@osdl.org on Tue, Apr 13, 2004 at 05:03:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Do races in access() actually matter?  I mean, some other process could
> change things a nanosecond after access() has completed and the value which
> the access() caller received is wrong anyway.
> 
> Or is there some deeper problem which you are addressing here?

There is a race where, the saved off capabilities could blow away recently
updated capabilites when they are restored.  But, it's only raceable
against tasks that have SETPCAP and are setting another task's caps.
Otherwise it's serialised by the fact that we're dealing with a single
task that can only be in one syscall at a time.  Fixing it would require
something like passing creds into the permission function, instead of
them being deduced from current, a rather invasive change.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
