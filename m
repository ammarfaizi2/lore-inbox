Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUDMXLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 19:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUDMXLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 19:11:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:41965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263617AbUDMXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 19:11:37 -0400
Date: Tue, 13 Apr 2004 16:11:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: Chris Wright <chrisw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-ID: <20040413161135.L21045@build.pdx.osdl.net>
References: <1081881778.5585.16.camel@bluerhyme.real3> <20040413115052.O22989@build.pdx.osdl.net> <1081883544.5585.30.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1081883544.5585.30.camel@bluerhyme.real3>; from Fabian.Frederick@skynet.be on Tue, Apr 13, 2004 at 09:12:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabian Frederick (Fabian.Frederick@skynet.be) wrote:
> Well, the only major function behind user_walk is path_lookup.
> This one has some calls with the nameidata.Other process seems
> current->fs->xxx relevant read-only.Maybe you mean the
> read_lock(&current->fs->lock) which could bring a deadlock as we
> task->lock before ? 

No, point is simply that there's implicit permission check in
__user_walk().

> If user_walk had to run in ruid, why would we have permission() then ?

It's how the standards require the call to be implemented.  The
access(2) check verifies access to the pathname using the ruid not euid.
Part of valid access includes search access on the directory elements of
the full pathname.  Those tests are done during __user_walk.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
