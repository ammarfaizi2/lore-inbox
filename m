Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTDWTOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTDWTOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:14:10 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:38924 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264531AbTDWTOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:14:08 -0400
Date: Wed, 23 Apr 2003 20:26:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423202614.A5890@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423194501.B5295@infradead.org> <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 23, 2003 at 03:17:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:17:57PM -0400, Stephen Smalley wrote:
> On Wed, 2003-04-23 at 14:45, Christoph Hellwig wrote:
> > Randomly userland shouldn't deal with these xattrs.  Remember you are
> > talking about the ondisk represenation of your labelling - nothing
> > but the labelling tools should ever touch it.
> 
> Not true.  ls should be able to display the security label.  find should
> be able to locate files that have specific security labels.  cp should
> be able to preserve the security label on copies.  logrotate should be
> able to preserve the security label when rotating logs.  crond should be
> able to check the security label on a crontab spool file to verify
> consistency with the user's credentials with which the cron job will
> run.  login/sshd need to set the security label on the user's terminal
> device.  You'll find plenty of examples of patched userland in SELinux,
> but none of these patches are specific to a particular set of security
> attributes.  They just handle them as strings.

And all these should _not_ happen in the actual tools but in a
pluggable security module (something like pam).  Encoding any security
policy and especially a xattr name in those utils is bad.

And see, you start to contradict what you said before - with your
suggestion cron has to know what the label means, so your selinux
cron would do stupid things with say may Posix 1003.1e MAC filesystem.
