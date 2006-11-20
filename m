Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966395AbWKTSxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966395AbWKTSxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966423AbWKTSxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:53:43 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:10379 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S966431AbWKTSxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:53:42 -0500
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
	overridden
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
In-Reply-To: <26860.1163607813@redhat.com>
References: <XMMS.LNX.4.64.0611151115360.8593@d.namei>
	 <XMMS.LNX.4.64.0611141618300.25022@d.namei>
	 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
	 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
	 <15153.1163593562@redhat.com>   <26860.1163607813@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 20 Nov 2006 13:49:53 -0500
Message-Id: <1164048593.13758.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 16:23 +0000, David Howells wrote:
> James Morris <jmorris@namei.org> wrote:
> 
> > Well, the value can be changed at any time, so you could be using a 
> > temporary fscreate value, or your new value could be overwritten 
> > immediately by writing to /proc/$$/attr/fscreate
> 
> Ah.  Hmmm.  By whom?  In selinux_setprocattr():
> 
> 	if (current != p) {
> 		/* SELinux only allows a process to change its own
> 		   security attributes. */
> 		return -EACCES;
> 	}
> 
> But current busy inside the cache and can't do this.

Correct; this is no different than modifying ->fsuid temporarily.

> > I think we need to add a separate field for this purpose, which can only 
> > be written to via the in-kernel API and overrides fscreate.
> 
> So, like my acts-as security ID patch?
> 
> Would it still need to be controlled by MAC policy in that case?  Doing so is
> a bit of a pain as it means I have a whole bunch of extra failures I still
> need to check for, and the race in which the rules might change is still a
> possibility I have to deal with.

I don't see any value added by introducing yet another field for the
create SID (unlike the actor SID, where we need to distinguish it for
certain checks where the task is the target rather than the actor), so I
don't advocate this approach.

I still suspect that the task flag approach would have been rather
simpler...

-- 
Stephen Smalley
National Security Agency

