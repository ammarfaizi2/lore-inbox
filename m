Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbULOX3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbULOX3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbULOX3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:29:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:16093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262535AbULOX0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:26:43 -0500
Date: Wed, 15 Dec 2004 15:26:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Properly split capset_check+capset_set
Message-ID: <20041215152639.W469@build.pdx.osdl.net>
References: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Wed, Dec 15, 2004 at 01:48:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> As Stephen Smalley pointed out, the cap_capset_check code is redundant
> with what is hardcoded in kernel/capability.c:sys_capset().  On the
> other hand, because the security_capset_set hook is responsible for
> doing both an authorization check and doing the actual change,
> (particularly, in the case of a cap_set_all or cap_set_pg), when
> stacking security modules, the first module may complete the
> capset_set before the second module refuses permission.

The problem is that the module was (theoretically) allowed to manage
capability bits all on its own.  I think it's a bit of a braindamaged
idea though, and the bits should just stay in the ->cap_* fields.

> The attached patch (against 2.6.10-rc3-mm1 w/ ioctl patch) removes the
> redundant cap_capset_check hook and moves the security_capset_check
> call to just before security_capset_set.  The selinux_capset_set hook
> now simply sets the capability (through its secondary), while
> selinux_capset_check checks the authorization permission.

I think Stephen mentioned this already, but you lose an error now,
where you continue in cap_set_all().

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
