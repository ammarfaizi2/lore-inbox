Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTDXTbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbTDXTbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:31:04 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39667 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264400AbTDXTbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:31:02 -0400
Date: Thu, 24 Apr 2003 13:40:40 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chris@wirex.com>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424134040.T26054@schatzie.adilger.int>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Chris Wright <chris@wirex.com>,
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
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Apr 24, 2003 at 03:02:51PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2003  15:02 -0400, Stephen Smalley wrote:
> I don't think that would help.  As I mentioned during the earlier
> discussion with Andreas, you want to be able to allow the security
> module to call the inode getxattr and setxattr operations without
> restriction for internal management of the security labels, while
> applying access controls to user processes invoking the [gs]etxattr
> system calls.  Hence, you don't want the permission check implemented in
> the handler; it is better to handle the checking entirely via the LSM
> hooks in the [gs]etxattr calls and allow unrestricted internal use of
> the inode [gs]etxattr operations by the module.  Capability checks are
> also too coarse-grained; you want to be able to perform a permission
> check based on the process and the inode attributes, not just a
> process-based check.
> 
> If the intent of the trusted namespace is for attributes that can be
> managed by superuser processes (this is my impression), then I think it
> would be better to create a separate namespace and handler for security
> modules for clarity.  Or at least for MAC modules.

Wasn't part of the LSM setup done in a way that there would be "default"
handlers for the hooks for normal PID/capability checking in the absence
of another LSM module?  I thought that was one of the reasons LSM hooks
were accepted into the kernel, since this would allow even the default
file/process permission checks to be compiled out for, say, embedded
systems that only run as root anyways.

Couldn't that be used to do the trusted-namespace- means-CAP_SYS_ADMIN
checks, but it can be replaced by other LSM security modules if desired?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

