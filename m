Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVAXGfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVAXGfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVAXGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:33:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:5819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261452AbVAXG2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:28:40 -0500
Date: Sun, 23 Jan 2005 22:28:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LSM hook addition?
Message-ID: <20050123222836.V469@build.pdx.osdl.net>
References: <41F48E70.5090200@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41F48E70.5090200@comcast.net>; from nigelenki@comcast.net on Mon, Jan 24, 2005 at 12:58:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
> Can someone point me to documentation or give me a small patch to add an
> LSM hook to kernel 2.6.10 in fs/namei.c at line 1986:
> 
>         new_dentry = lookup_create(&nd, 0);
>         error = PTR_ERR(new_dentry);
>         if (!IS_ERR(new_dentry)) {
>                 error = security_inode_make_hardlink(old_nd); // ADD
>                 error = vfs_link(old_nd.dentry, nd.dentry->d_inode,
> new_dentry);

It's already there.  Look at the code in vfs_link.  The security_inode_link
hook is documented in include/linux/security.h.  And the restrictive policy
you're referring to is already codified in the owlsm module.  See the
do_owlsm_link() function here (code's a bit old, but basic idea is still
relevant):

http://lsm.bkbits.net:8080/lsm-2.6/anno/security/owlsm.h@1.9?nav=index.html|src/|src/security

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
