Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTI3GRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTI3GRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:17:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:45441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263130AbTI3GRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:17:01 -0400
Date: Mon, 29 Sep 2003 23:16:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [RFC][PATCH] Pass nameidata to security_inode_permission hook
Message-ID: <20030929231658.B10999@build.pdx.osdl.net>
References: <1064420018.20804.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1064420018.20804.81.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Sep 24, 2003 at 12:13:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> This patch against 2.6.0-test5 changes the security_inode_permission
> hook to also take a nameidata parameter in addition to the existing
> inode and mask parameters.  A nameidata is already passed (although
> sometimes NULL) to fs/namei.c:permission(), and the patch changes
> exec_permission_lite() to also take a nameidata parameter so that it can
> pass it along to the security hook.  The patch includes corresponding
> changes to the SELinux module to use the nameidata information when it
> is available; this allows SELinux to include pathname information in
> audit messages when a nameidata structure was supplied.  If anyone has
> any objections to this change, please let me know.

Looks like Andrew already picked this up.  I'll put it in the LSM tree
as well.  It'd be nice if nameidata were never NULL and we could drop
the inode argument altogether.  But we can make that change when the VFS
supports it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
