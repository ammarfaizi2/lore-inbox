Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTDWSpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTDWSpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:45:23 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:11766 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264225AbTDWSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:45:13 -0400
Date: Wed, 23 Apr 2003 12:54:52 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423125452.I26054@schatzie.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030423112548.B15094@figure1.int.wirex.com>; from chris@wirex.com on Wed, Apr 23, 2003 at 11:25:49AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 23, 2003  11:25 -0700, Chris Wright wrote:
> * Christoph Hellwig (hch@infradead.org) wrote:
> > The other question is why do you name them system.security?  The name
> > sounds a bit too generic to me.  ACLs are certainly a security feature
> > and have different ATTRS, similar for the Posix capability and MAC
> > support in XFS.  As selinux is the flask implementation for Linux
> > what about system.flask_label?  (or system.selinux_label?)
> 
> It's really a namespace issue for user apps trying to deal with xattrs.
> Being able to display the xattrs associated with a file in sane way,
> like getxattr(path, "system.security", ...).  Otherwise something like
> listxattr() then gettxttr(... "system.security.[blah]" ...).  Total
> freeform naming is a headache for userspace to deal with.  Esp. since we
> don't want to teach all userland tools about each individual module/policy.

Well, with the exception of backup/restore (which will just treat this
EA data as opaque and doesn't really care whether the names are fixed
or not), the tools DO need to understand each individual module
or policy in order to make any sense of the data.  Otherwise, all you
can do is print out some binary blob which is no use to anyone.

So, either the tools look for "system.security", and then have to
understand an internal magic for each module to know what to do with
the data, or it looks for "system.<modulename>" for only module names
that it actually understands.

The only reason to use a common "system.security" is if the actual data
stored therein was usable by more than a single security module.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

