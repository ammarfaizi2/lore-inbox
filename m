Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTDXTkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDXTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:40:41 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:64757 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263818AbTDXTkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:40:37 -0400
Date: Thu, 24 Apr 2003 12:47:55 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424124755.G15094@figure1.int.wirex.com>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Stephen Tweedie <sct@redhat.com>,
	lsm <linux-security-module@wirex.com>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030423194501.B5295@infradead.org> <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil> <20030423202614.A5890@infradead.org> <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil> <20030423212004.A7383@infradead.org> <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil> <20030424140358.A30888@infradead.org> <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil> <20030424113615.F15094@figure1.int.wirex.com> <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Apr 24, 2003 at 03:02:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2003-04-24 at 14:36, Chris Wright wrote:
> > Or perhaps introducing some of the CAP_MAC_* bits.
> 
> I don't think that would help.  As I mentioned during the earlier
> discussion with Andreas, you want to be able to allow the security
> module to call the inode getxattr and setxattr operations without
> restriction for internal management of the security labels, while
> applying access controls to user processes invoking the [gs]etxattr
> system calls.  Hence, you don't want the permission check implemented in
> the handler; it is better to handle the checking entirely via the LSM
> hooks in the [gs]etxattr calls and allow unrestricted internal use of
> the inode [gs]etxattr operations by the module.  Capability checks are

Yes, this makes sense to me.

> also too coarse-grained; you want to be able to perform a permission
> check based on the process and the inode attributes, not just a
> process-based check.

Of course, good point.  I thought I might regret throwing CAP_ into the
picture ;-)

> If the intent of the trusted namespace is for attributes that can be
> managed by superuser processes (this is my impression), then I think it
> would be better to create a separate namespace and handler for security
> modules for clarity.  Or at least for MAC modules.

Yes, there was also some mention of the permission issue w.r.t. HSM and
(i vaguely recall) an xattr interface proposed that noted if the request was
internal from the kernel (skip the capable check) or on behalf of user.
If this were carried through, it could suffice, no?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
