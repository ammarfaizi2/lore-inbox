Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUDWRK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUDWRK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUDWRK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:10:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:34997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264880AbUDWRK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:10:27 -0400
Date: Fri, 23 Apr 2004 10:10:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
Message-ID: <20040423101025.J21045@build.pdx.osdl.net>
References: <10159129.1082704563424.JavaMail.pwaechtler@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10159129.1082704563424.JavaMail.pwaechtler@mac.com>; from pwaechtler@mac.com on Fri, Apr 23, 2004 at 09:16:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Waechtler (pwaechtler@mac.com) wrote:
> On Thursday, April 22, 2004, at 09:53PM, Chris Wright <chrisw@osdl.org> wrote:
> >This patch breaks various ptrace() checks.
> 
> Care to share your wisdom? No? Then please don't reply

-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;

Changes like that break ptrace authentication checks.  Look more closely
at what mm->dumpable is used for, you'll see checks like:

	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
		goto out;

BTW, putting the patch inline makes it easier to comment directly on the
patch.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
