Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTDOSHo (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTDOSHo 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:07:44 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:39079 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262883AbTDOSHm 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:07:42 -0400
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: richard offer <offer@sgi.com>
Cc: Andreas Gruenbacher <ag@bestbits.at>,
       Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <385390000.1050425884@changeling.engr.sgi.com>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
	 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
	 <385390000.1050425884@changeling.engr.sgi.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1050430776.1051.137.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 14:19:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-15 at 12:58, richard offer wrote:
> I see modules as empheral, but attritbutes as permanant. If I'm running one
> LSM module, I reboot and use a different LSM module, what happens to the
> attributes that the first module added to the file ?

I'm not going to switch between a SELinux "module" and a non-SELinux
"module" or vice versa without relabeling the filesystem to an
appropriate initial state of security labels that is meaningful to the
"module" I want to use.  I also wouldn't be performing such switching at
all on any real systems.

> Either we should guarantee that modules only touch attributes they know
> about---ignoring all others (but not overwriting them), or we have separate
> namespaces for each module's attributes.

A security module can sanity check the first few bytes of the attribute
value if it desires, and handle a mismatch as it desires.  That is a
policy issue and up to the module writer.

You also need to consider the implications for userspace of using a
separate attribute name for each security module.  Do you really want to
maintain your own patches for all of the utilities to let users get and
set file security labels using your attribute name?  Note that we can
add or remove security attributes to/from the SELinux security context
without requiring changes to our patches for the utilities; the utility
patches don't have to be tied to a specific security model.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

