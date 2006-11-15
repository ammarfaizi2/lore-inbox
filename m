Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbWKOQZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWKOQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030657AbWKOQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:25:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61078 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030658AbWKOQZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:25:57 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <XMMS.LNX.4.64.0611151115360.8593@d.namei> 
References: <XMMS.LNX.4.64.0611151115360.8593@d.namei>  <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 16:23:33 +0000
Message-ID: <26860.1163607813@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> Well, the value can be changed at any time, so you could be using a 
> temporary fscreate value, or your new value could be overwritten 
> immediately by writing to /proc/$$/attr/fscreate

Ah.  Hmmm.  By whom?  In selinux_setprocattr():

	if (current != p) {
		/* SELinux only allows a process to change its own
		   security attributes. */
		return -EACCES;
	}

But current busy inside the cache and can't do this.

> I think we need to add a separate field for this purpose, which can only 
> be written to via the in-kernel API and overrides fscreate.

So, like my acts-as security ID patch?

Would it still need to be controlled by MAC policy in that case?  Doing so is
a bit of a pain as it means I have a whole bunch of extra failures I still
need to check for, and the race in which the rules might change is still a
possibility I have to deal with.

David
