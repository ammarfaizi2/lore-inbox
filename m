Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbTDWTCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTDWTCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:02:55 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:46798 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264237AbTDWTCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:02:50 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423125452.I26054@schatzie.adilger.int>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423125452.I26054@schatzie.adilger.int>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051125279.14761.141.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 15:14:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 14:54, Andreas Dilger wrote:
> Well, with the exception of backup/restore (which will just treat this
> EA data as opaque and doesn't really care whether the names are fixed
> or not), the tools DO need to understand each individual module
> or policy in order to make any sense of the data.  Otherwise, all you
> can do is print out some binary blob which is no use to anyone.

You are assuming that the ondisk representation is a binary blob.  If
you store a string representation as your security label, then your
userspace tools can operate on it cleanly without caring what it
actually means.  SELinux includes patched versions of many of the user
utilities that can get or set file security labels, and it doesn't
matter whether the security label consists of a MLS range or a TE domain
or a RBAC role or any combination of them.

For MAC, you want to preserve meaningful security information on the
filesystem partition itself (and in any backups), not some arbitrary
integer that might be remapped at any time to a completely different
meaning or that might mean something quite different if you mount the
disk on some other system.  A human-readable string representation is
preferable here.

> So, either the tools look for "system.security", and then have to
> understand an internal magic for each module to know what to do with
> the data, or it looks for "system.<modulename>" for only module names
> that it actually understands.

Again, if you are using a string representation, then most of your
userland can simply display it or take input from the user and pass it
down without caring about the meaning of the string.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

