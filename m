Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTDUVSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTDUVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:18:46 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:55794 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262196AbTDUVSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:18:45 -0400
Date: Mon, 21 Apr 2003 14:26:24 -0700
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER]  Help Needed!
Message-ID: <20030421142624.B11886@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org
References: <20030327091058.A22868@figure1.int.wirex.com> <Pine.GSO.4.44.0304210042170.19252-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0304210042170.19252-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Mon, Apr 21, 2003 at 12:49:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> It seems to us that create_dev can only be called at boot time (the
> "__init" attribute), so devfs_name must be an untainted kernel pointer.
> The warning on line 437 isn't a real error.

Yes.

> However, this pointer is finally passed into strncpy_from_user through the
> call chain [ sys_symlink (devfs_name, name) --> getname (oldname) -->
> do_getname(filename, _) --> strncpy_from_user (_, filename, _)].  Is it
> okay to call *_from_user functions with the second arguements untainted?
> What will access_ok(VERIFY_READ, src, 1) return?

This checks against the current addr_limit which depends on the context.
KERNEL_DS lets this check succeed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
