Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVBIHEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVBIHEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 02:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVBIHEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 02:04:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:12463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261796AbVBIHEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 02:04:51 -0500
Date: Tue, 8 Feb 2005 23:04:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Mark F. Haigh" <Mark.Haigh@SpirentCom.COM>
Cc: chrisw@osdl.org, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
Message-ID: <20050208230447.V24171@build.pdx.osdl.net>
References: <420988C1.5030408@spirentcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <420988C1.5030408@spirentcom.com>; from Mark.Haigh@SpirentCom.COM on Tue, Feb 08, 2005 at 07:51:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

* Mark F. Haigh (Mark.Haigh@SpirentCom.COM) wrote:
> [Aargh!  Missing Signed-off-by.]
> 
> Unless I'm missing something, in kernel/fork.c, dup_mmap():
> 
> 			if (security_vm_enough_memory(len))
> 				goto fail_nomem;
> /* ... */
> fail_nomem:
> 	retval = -ENOMEM;
> 	vm_unacct_memory(charge);
> /* ... */
> 
> If security_vm_enough_memory() fails there, then we vm_unacct_memory()
> that we never accounted (if security_vm_enough_memory() fails, no memory
> is accounted).

You missed one subtle point.  That failure case actually unaccts 0 pages
(note the use of charge).  Not the nicest, but I believe correct.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
