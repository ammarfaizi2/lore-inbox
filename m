Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTDWTlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDWTkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:40:32 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:52944 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263612AbTDWTkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:40:18 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423202614.A5890@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 15:52:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 15:26, Christoph Hellwig wrote:
> And all these should _not_ happen in the actual tools but in a
> pluggable security module (something like pam).  Encoding any security
> policy and especially a xattr name in those utils is bad.

For many of the patched utilities, there would be no encoding of any
specific policy/module as long as you have a single attribute name,
since they are just handling the labels as strings.  It isn't clear that
PAM-like API is feasible for the wide range of different applications
that need to deal with security labels.  I don't see what value there is
in adding an extra level of indirection just to get the security label
of a file and display it, or to get it and use it to relabel a new copy
of the file to the same label.  

As a side note, please keep in mind that SELinux is itself a generic
framework for MAC policies, provides encapsulation of security labels,
and allows security models and attributes to be added or removed without
requiring changes outside of the security policy engine, which itself is
an encapsulated component of the SELinux module.

> And see, you start to contradict what you said before - with your
> suggestion cron has to know what the label means, so your selinux
> cron would do stupid things with say may Posix 1003.1e MAC filesystem.

Not exactly.  Our patch to crond uses a generic policy API that was
designed to support many different security models, so it doesn't have
to be specific to SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

