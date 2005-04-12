Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVDLGEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVDLGEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVDLGDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:03:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5031 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262059AbVDLFqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:46:19 -0400
Subject: Re: [RFC][PATCH] Simple privacy enhancement for /proc/<pid>
From: Albert Cahalan <albert@users.sf.net>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Bodo Eggert <7eggert@gmx.de>, Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
In-Reply-To: <20050410153855.GA24905@lsrfire.ath.cx>
References: <20050410153855.GA24905@lsrfire.ath.cx>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 01:29:35 -0400
Message-Id: <1113283776.2325.167.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 17:38 +0200, Rene Scharfe wrote:

> Albert, allowing access based on tty sounds nice, but it _is_ expansive.
> More importantly, perhaps, it would "virtualize" /proc: every user would
> see different permissions for certain files in there.  That's too comlex
> for my taste.

If you really can't allow access based on tty, then at least allow
access if any UID value matches any UID value. Without this, a user
can not always see a setuid program they are running.

> First, configuring via kernel parameters is sufficient.  It simplifies
> implementation a lot because we know the settings cannot change.  And we
> don't need the added flexibility of sysctls anyway -- I assume these
> parameters are set at installation time and never touched again.

This means mucking with boot parameters, which can be a pain.
The various boot loaders do not all use the same config file.

> Then I suppose we don't need to be able to fine-tune the permissions for
> each file in /proc/<pid>/.  All that we need is a distinction between
> "normal" users (which are to be restricted) and admins (which need to
> see everything).

The /proc/*/maps file sure is different from the /proc/*/status file.
The same for all the others, really.

> This patch introduces two kernel parameters: proc.privacy and proc.gid.
> The group ID attribute of all files below /proc/<pid> is set to
> proc.gid, but only if you activate the feature by setting proc.privacy
> to a non-zero value.

This is very bad. Please do not change the GID as seen by
the stat() call. This value is used.


