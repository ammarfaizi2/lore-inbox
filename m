Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbTDXNhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTDXNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:37:52 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:46306 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263674AbTDXNhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:37:50 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030424140358.A30888@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
	 <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423212004.A7383@infradead.org>
	 <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424140358.A30888@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 09:49:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 09:03, Christoph Hellwig wrote:
> Hmm, what would you think of changing the xattr_trusted security
> model to fit your needs?  It's so far unused outside XFS and there's
> maybe a chance changing it.

It would require removing the capable(CAP_SYS_ADMIN) checks from the
xattr_trusted.c handler and implementing them in the capabilities
security module (and corresponding superuser tests in the dummy security
module) via the inode_setxattr and inode_getxattr hook functions.  This
would then permit security modules to implement their own permission
checking logic for getxattr and setxattr calls for their attributes, and
it would allow security modules to internally call the getxattr and
setxattr inode operations without being subjected to these checks in
order to manage the attributes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

