Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTISXJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTISXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:07:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:42383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261801AbTISXEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:04:46 -0400
Date: Fri, 19 Sep 2003 16:04:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, sds@epoch.ncsc.mil
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030919160439.J27079@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
> START -->
> 1232:			c = kmalloc(sizeof(*c), GFP_KERNEL);
> 1233:			if (!c) {
> 1234:				rc = -ENOMEM;
> 1235:				goto bad;
> 1236:			}
> 1237:			memset(c, 0, sizeof(*c));
>         ... DELETED 182 lines ...

You missed a reference to the context is stored in the policydb:
			p->ocontexts[i] = c;
> END -->
> 1427:	return rc;
> 1428:bad:
> 1429:	policydb_destroy(p);

The policydb is destroyed on error, which will free the context.  I
don't think this is a bug.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
