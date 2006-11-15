Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966798AbWKOM2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966798AbWKOM2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966799AbWKOM2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:28:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966798AbWKOM2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:28:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <XMMS.LNX.4.64.0611141618300.25022@d.namei> 
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 12:26:02 +0000
Message-ID: <15153.1163593562@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +static u32 selinux_set_fscreate_secid(u32 secid)
> ...
> The ability to set this needs to be mediated via MAC policy.

There could a problem with that...  Is it possible for there to be a race?  I
have to call the function twice per cache op: once to set the file creation
security ID and once to restore it back to what it was.

However, what happens if I can't restore the original security ID (perhaps the
rules changed between the two invocations)?  I can't let the task continue as
it's now running with the wrong security...

David
