Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDOOoc>; Mon, 15 Apr 2002 10:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312797AbSDOOob>; Mon, 15 Apr 2002 10:44:31 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:26863 "HELO
	egghead.curl.com") by vger.kernel.org with SMTP id <S312790AbSDOOob>;
	Mon, 15 Apr 2002 10:44:31 -0400
To: xystrus@haxm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: link() security
In-Reply-To: <20020411192122.F5777@pizzashack.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Apr 2002 10:44:30 -0400
Message-ID: <s5gpu11rpgx.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xystrus <xystrus@haxm.com> writes:

> Many linux systems, like Slackware and SuSE, favor the permissions
> 1777 for the mail spool directory.  This is a good policy from a
> security perspective, as it prevents mail utilities from requiring
> SUID/SGID root or mail privileges to create a user's spool and/or lock
> files.

Actually, that is a horrible policy from a security perspective.  The
shared mail spool itself is a poor design and always has been.

A better design is to use a separate spool directory for each user
(/var/spool/mail/user/ or ~user/mail/ or somesuch), and only allow
that user to access it at all.  This solves *all* of the security
problems you mention:

   *) It avoids attacks based on race conditions, because you cannot
      create files in somebody else's spool.

   *) Admins can manage space with quotas or partitions just like they
      do for user home directories (i.e., it is a solved problem).

   *) You cannot link() to somebody else's spool file because you
      cannot even read the directory in which it resides.

The solution to a fundamentally broken spool design is to fix that
design, not to patch the kernel in nonstandard ways to plug just one
of its multiple flaws.

And yes, there are MTAs which use a directory per user by default.
Fix your MTA, do not hack the kernel.

All just My Opinion, of course.

 - Pat
