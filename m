Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUFDSS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUFDSS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUFDSS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:18:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:13038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265898AbUFDSSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:18:13 -0400
Date: Fri, 4 Jun 2004 11:18:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: mlock as non-root: use rlimits
Message-ID: <20040604111804.T22989@build.pdx.osdl.net>
References: <20040604112845.GA28413@devserv.devel.redhat.com> <20040604151251.GD16897@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040604151251.GD16897@devserv.devel.redhat.com>; from arjanv@redhat.com on Fri, Jun 04, 2004 at 05:12:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> non-root" issue, which recently cropped up again in relation to hugetlbfs
> and Oracle. The proposed solution comes down to using the MEMLOCK rlimit,
> which previously was used to restrict how much memory *root* processes can
> mlock as limit for non-root processes, and let root (well CAP_IPC_LOCK
> processes) mlock to infinity (which was the rlimit default anyway).
> The default behavior of the kernel doesn't change with this patch, but with
> this patch the sysadmin can use the standard rlimit mechanism (eg via PAM
> usually) to allow specific users to mlock memory, for example the oracle
> database user account.
>                                                                               
> Comments?

Hi Arjan, how is this different from the last time this patch was posted?

http://marc.theaimsgroup.com/?l=linux-kernel&m=108087017610947&w=2

The hugetlbfs and SHM_LOCK bits don't work well with rlimits.  For
example, it's trivial to corrupt the locked_vm count with a SHM_LOCK
segment.  I like this, but I think it only works with mlock().  Did I
miss something?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
