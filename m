Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTDXSvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTDXSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:51:13 -0400
Received: from [144.51.25.10] ([144.51.25.10]:44521 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S263812AbTDXSvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:51:12 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chris@wirex.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030424113615.F15094@figure1.int.wirex.com>
References: <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
	 <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423212004.A7383@infradead.org>
	 <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424140358.A30888@infradead.org>
	 <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424113615.F15094@figure1.int.wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 15:02:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 14:36, Chris Wright wrote:
> Or perhaps introducing some of the CAP_MAC_* bits.

I don't think that would help.  As I mentioned during the earlier
discussion with Andreas, you want to be able to allow the security
module to call the inode getxattr and setxattr operations without
restriction for internal management of the security labels, while
applying access controls to user processes invoking the [gs]etxattr
system calls.  Hence, you don't want the permission check implemented in
the handler; it is better to handle the checking entirely via the LSM
hooks in the [gs]etxattr calls and allow unrestricted internal use of
the inode [gs]etxattr operations by the module.  Capability checks are
also too coarse-grained; you want to be able to perform a permission
check based on the process and the inode attributes, not just a
process-based check.

If the intent of the trusted namespace is for attributes that can be
managed by superuser processes (this is my impression), then I think it
would be better to create a separate namespace and handler for security
modules for clarity.  Or at least for MAC modules.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

