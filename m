Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTDXS3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDXS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:29:16 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:22013 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263423AbTDXS3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:29:10 -0400
Date: Thu, 24 Apr 2003 11:36:15 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424113615.F15094@figure1.int.wirex.com>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Stephen Tweedie <sct@redhat.com>,
	lsm <linux-security-module@wirex.com>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423194501.B5295@infradead.org> <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil> <20030423202614.A5890@infradead.org> <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil> <20030423212004.A7383@infradead.org> <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil> <20030424140358.A30888@infradead.org> <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Apr 24, 2003 at 09:49:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2003-04-24 at 09:03, Christoph Hellwig wrote:
> > Hmm, what would you think of changing the xattr_trusted security
> > model to fit your needs?  It's so far unused outside XFS and there's
> > maybe a chance changing it.
> 
> It would require removing the capable(CAP_SYS_ADMIN) checks from the
> xattr_trusted.c handler and implementing them in the capabilities
> security module (and corresponding superuser tests in the dummy security
> module) via the inode_setxattr and inode_getxattr hook functions.  This
> would then permit security modules to implement their own permission
> checking logic for getxattr and setxattr calls for their attributes, and
> it would allow security modules to internally call the getxattr and
> setxattr inode operations without being subjected to these checks in
> order to manage the attributes.

Or perhaps introducing some of the CAP_MAC_* bits.  In either case, it'd
be nice to reuse xattr_trusted if possible, IMHO.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
