Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbUK3TdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUK3TdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUK3TbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:31:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:33988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262282AbUK3T3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:29:30 -0500
Date: Tue, 30 Nov 2004 11:29:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jeff Mahoney <jeffm@suse.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041130112903.C2357@build.pdx.osdl.net>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Nov 30, 2004 at 02:18:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2004-11-30 at 12:50, Andrew Morton wrote:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> <snip>
> > selinux-adds-a-private-inode-operation.patch
> >   selinux: adds a private inode operation
> 
> Below is a re-base to 2.6.10-rc2-mm4 of a patch I posted earlier during
> the original discussion of the above referenced patch.  This patch
> removes the unnecessary code in inode_doinit_with_dentry, replaces the
> unused inherits flag field (legacy from earlier code) with a private
> flag field, does not set the SID in selinux_inode_mark_private (leaving
> it with the unlabeled SID, which will ensure that we notice it if it
> ever reaches a SELinux permission check), and modifies SELinux
> permission checking functions and post_create() to test for the private
> flag and skip SELinux processing in that case.  Please include if/when
> the reiserfs/selinux patchset goes upstream.  I know that Chris Wright
> had raised the question of whether we should be using i_flags to convey
> the "private" nature of the inode rather than using a security hook, but
> didn't see any resolution of that issue.

My concerns are that the check has to be duplicated in any module,
and that thus far we've tried to keep out fs -> module communication,
letting vfs do it.  This could at least be fs -> vfs communication,
and then either vfs or security framework could check flags and never
call into module on fs private objects.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
