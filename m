Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULBNlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULBNlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbULBNlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:41:23 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:23732 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261616AbULBNlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:41:20 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
In-Reply-To: <20041201170141.V2357@build.pdx.osdl.net>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
	 <20041130112903.C2357@build.pdx.osdl.net>
	 <20041130194328.GA28126@infradead.org>
	 <20041201233203.GA22773@locomotive.unixthugs.org>
	 <20041201170141.V2357@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101994347.26015.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 08:32:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 20:01, Chris Wright wrote:
> This sounds a bit better.  BTW, which is the call chain that locks? smth like
> open->permission->selinux_hook_does_getxattr->reiser_getxattr->open->permission?

IIRC, the original deadlock call chain was when SELinux tried to set the
security attribute on a newly created file from the post_create hooks. 
Looked something like (SELinux) post_create -> reiser_setxattr -> ... ->
open_xa_dir -> reiserfs_mkdir -> d_instantiate ->
selinux_d_instantiate() -> inode_doinit_with_dentry() ->
reiser_getxattr.  First reported in
http://marc.theaimsgroup.com/?l=linux-kernel&m=108625196416654&w=2, but
that only addressed the deadlock issue, not the permission checking
problem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

