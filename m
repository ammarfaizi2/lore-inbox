Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTDXTw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDXTw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:52:28 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60396 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263402AbTDXTw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:52:27 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Chris Wright <chris@wirex.com>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030424134040.T26054@schatzie.adilger.int>
References: <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
	 <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423212004.A7383@infradead.org>
	 <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424140358.A30888@infradead.org>
	 <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424113615.F15094@figure1.int.wirex.com>
	 <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424134040.T26054@schatzie.adilger.int>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051214655.20300.118.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 16:04:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 15:40, Andreas Dilger wrote:
> Couldn't that be used to do the trusted-namespace- means-CAP_SYS_ADMIN
> checks, but it can be replaced by other LSM security modules if desired?

If we move the CAP_SYS_ADMIN checks from the trusted xattr handlers to
the corresponding hook functions in the capabilities module, then we can
replace those checks with our own permission checking for user process
access to trusted.selinux and avoid any restrictions when the SELinux
module internally performs getxattr and setxattr inode operations to
manage the security labels.  This isn't difficult to implement, but
implies a change in meaning for the trusted namespace.  As I understand
it, that namespace is intended for attributes that can be managed by
superuser processes.  Using that namespace for SELinux means that it
will also be used for attributes managed and used internally by the
security module for access control purposes.  I'm not sure that you want
to mix them; it would be similar to putting ACLs in the trusted
namespace.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

