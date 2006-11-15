Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030641AbWKOQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbWKOQTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWKOQTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:19:07 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:41124 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030641AbWKOQTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:19:04 -0500
Date: Wed, 15 Nov 2006 11:19:00 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden 
In-Reply-To: <15153.1163593562@redhat.com>
Message-ID: <XMMS.LNX.4.64.0611151115360.8593@d.namei>
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei> 
 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
 <15153.1163593562@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > > +static u32 selinux_set_fscreate_secid(u32 secid)
> > ...
> > The ability to set this needs to be mediated via MAC policy.
> 
> There could a problem with that...  Is it possible for there to be a race?

Well, the value can be changed at any time, so you could be using a 
temporary fscreate value, or your new value could be overwritten 
immediately by writing to /proc/$$/attr/fscreate

I think we need to add a separate field for this purpose, which can only 
be written to via the in-kernel API and overrides fscreate.

> I have to call the function twice per cache op: once to set the file 
> creation security ID and once to restore it back to what it was.
> 
> However, what happens if I can't restore the original security ID (perhaps the
> rules changed between the two invocations)?  I can't let the task continue as
> it's now running with the wrong security...

Kill the task?



- James
-- 
James Morris
<jmorris@namei.org>
