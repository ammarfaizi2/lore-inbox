Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966421AbWKTSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966421AbWKTSpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966425AbWKTSpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:45:21 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:51843 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S966421AbWKTSpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:45:19 -0500
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
	overridden
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
In-Reply-To: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
	 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
	 <XMMS.LNX.4.64.0611141618300.25022@d.namei>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 20 Nov 2006 13:41:13 -0500
Message-Id: <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 16:19 -0500, James Morris wrote:
> On Tue, 14 Nov 2006, David Howells wrote:
> 
> > +static u32 selinux_set_fscreate_secid(u32 secid)
> > +{
> > +	struct task_security_struct *tsec = current->security;
> > +	u32 oldsid = tsec->create_sid;
> > +
> > +	tsec->create_sid = secid;
> > +	return oldsid;
> > +}
> 
> The ability to set this needs to be mediated via MAC policy.
> 
> See selinux_setprocattr()

That's different - selinux_set_fscreate_secid() is for internal use by a
kernel module that wishes to temporarily assume a particular fscreate
SID, whereas selinux_setprocattr() handles userspace writes
to /proc/self/attr nodes.  Imposing a permission check here makes no
sense.

-- 
Stephen Smalley
National Security Agency

