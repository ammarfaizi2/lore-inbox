Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbUAQSPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUAQSPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:15:22 -0500
Received: from thunk.org ([140.239.227.29]:27315 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266093AbUAQSPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:15:17 -0500
Date: Sat, 17 Jan 2004 11:41:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Andreas Gruenbacher <agruen@suse.de>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH 2/2] Default hooks protecting the XATTR_SECURITY_PREFIX namespace
Message-ID: <20040117164111.GA1058@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
	Andreas Gruenbacher <agruen@suse.de>,
	Michael Kerrisk <michael.kerrisk@gmx.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20040116131423.Q19023@osdlab.pdx.osdl.net> <20040116132004.R19023@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116132004.R19023@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:20:04PM -0800, Chris Wright wrote:
> Add default hooks for both the dummy and capability code to protect the
> XATTR_SECURITY_PREFIX namespace.  These EAs were fully accessible to
> unauthorized users, so a user that rebooted from an SELinux kernel to a
> default kernel would leave those critical EAs unprotected.
> 
>  include/linux/security.h |    6 ++++--
>  security/capability.c    |    3 +++
>  security/commoncap.c     |   22 ++++++++++++++++++++++
>  security/dummy.c         |    9 +++++++++
>  4 files changed, 38 insertions(+), 2 deletions(-)

Everyone realizes the protection is minimal, right?  If you boot into
a default kernel, and administrator is careless with the system
configs because SELinux means that "it doesn't matter" if the intruder
cracks root, then all someone has to do is crack root when the system
is mistakenly booted using a default kernel.  At that point, running
debugfs or some other tool with direct access to the hard drive is the
least of your problems; the intruder can just simply trojan some
executable (or the kernel for that matter) that will be trusted once
SELinux is booted again, and it's all over....

						- Ted
