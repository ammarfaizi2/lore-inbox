Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVBIT2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVBIT2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVBIT2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:28:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:23719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbVBIT2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:28:47 -0500
Date: Wed, 9 Feb 2005 11:28:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>,
       "Mark F. Haigh" <Mark.Haigh@SpirentCom.COM>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
Message-ID: <20050209112846.A24171@build.pdx.osdl.net>
References: <420988C1.5030408@spirentcom.com> <20050208230447.V24171@build.pdx.osdl.net> <Pine.LNX.4.61.0502091223310.5842@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0502091223310.5842@goblin.wat.veritas.com>; from hugh@veritas.com on Wed, Feb 09, 2005 at 12:30:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> dup_mmap's charge starts out at 0 and gets added to each time around
> the loop through vmas; if security_vm_enough_memory fails at any point
> in that loop, we need to vm_unacct_memory the charge already accumulated.

If that's the requirement, then it's broken as is, because there is
nothing accumulating.  len is re-determined each pass, and charge is
reset each pass.  But I think that it's ok, as we only care about the
last pass.  If dup_mmap() fails part way through, the cleanup path should
call unaccount for the (potentially) accounted by not fully setup vma then
call exit_mmap() and clear all the vmas that got accounted for already.
Either way, Mark's patch is not needed, and I don't think anything needs
patching in this area.  Hugh, do you agree?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
