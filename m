Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbTDXMn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTDXMn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:43:57 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3297 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263630AbTDXMnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:43:55 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423212004.A7383@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
	 <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423212004.A7383@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 08:55:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 16:20, Christoph Hellwig wrote:
> That doesn't matter at all for this question - if you have a selinux_label
> attribute you can add your different policies with string labels to
> it.  But don't mix it up with others.

Ok, so you still favor using a distinct attribute name for SELinux
attributes.  Andreas Gruenbacher had suggested during the earlier thread
that we use something like the xattr_trusted.c attribute handler, so
that a single xattr handler would cover all security modules but each
security module could have its own attribute name (security.selinux,
security.dte, security.capabilities, etc).  As I explained during that
thread, I don't think we want to use the trusted attribute handler
itself due to its permission checking model, but it would be easy to
make the xattr_security.c handler more like xattr_trusted.c in terms of
allowing arbitrary extensions of a "security." prefix.  Is that more to
your liking, or do you truly want a separate handler for each security
module?  I see the latter as undesirable as it requires each security
module to separately reserve a name and an index in each filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

