Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbUKVQaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUKVQaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUKVQaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:30:17 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:13486 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262142AbUKVPz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:55:26 -0500
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeffrey Mahoney <jeffm@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <1101130521.18273.9.camel@moss-spartans.epoch.ncsc.mil>
References: <20041121001318.GC979@locomotive.unixthugs.org>
	 <1101130521.18273.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101138640.18273.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 10:50:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 08:35, Stephen Smalley wrote:
> Don't we also need to modify inode_has_perm() to skip checking if the
> inode has the kernel SID (as is already done by socket_has_perm) to
> avoid the search checks when the reiserfs code looks up xattrs? 
> Otherwise, we'll see access attempts by the process context on
> directories with the kernel SID upon such lookups.

Actually, I think we need a new flag field in the inode_security_struct
to explicitly mark these "private" inodes for SELinux, so that
inode_has_perm() can skip permission checking on them while still
applying checks to any other inodes that may have the kernel SID (e.g.
/proc/pid inodes for kernel threads).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

