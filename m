Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbULGUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbULGUjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbULGUjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:39:05 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:32985 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261920AbULGUiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:38:55 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
In-Reply-To: <41B60B0F.1080201@suse.com>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
	 <20041130112903.C2357@build.pdx.osdl.net>
	 <20041130194328.GA28126@infradead.org>
	 <20041201233203.GA22773@locomotive.unixthugs.org>
	 <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>
	 <41B60B0F.1080201@suse.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102451289.25488.278.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Dec 2004 15:28:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 14:57, Jeff Mahoney wrote:
> However, selinux itself accesses inode lists internally that circumvent
> this. I believe I caught the major case that causes this, but I'd prefer
> someone with more intimate knowledge of selinux verify.

inodes are only added to the list (prior to superblock security
initialization, e.g. before initial policy load or during get_sb) by
inode_doinit_with_dentry, which in turn is called from
selinux_d_instantiate.  So if you've marked the inode private prior to
the d_instantiate call on it, and changed security_d_instantiate to not
call the security module for private inodes, how would a private inode
ever get into that list?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

