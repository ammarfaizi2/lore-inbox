Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVJFPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJFPEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVJFPEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:04:53 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:6838 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751068AbVJFPEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:04:52 -0400
Date: Thu, 6 Oct 2005 11:04:50 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
In-Reply-To: <23333.1128596048@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode>
References: <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> 
 <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net>
  <23333.1128596048@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, David Howells wrote:

> > Agree, in fact, I think we should always aim to keep housekeeping hooks 
> > separate from access control hooks.
> 
> What do you mean by separate? And this provides a chance for the LSM to deny
> the creation of a key before it's published.

Separate in terms of providing clear semantics in the API, so that you 
know a hook is either used for housekeeping (allocation, deallocation etc) 
or for access control.  But this is only an aim, an if it makes sense to 
combine housekeeping and access control functions in some specific 
instance, then so be it.


> > Access checks seem to be usually done before this point via 
> > lookup_user_key(), which is ideal.
> 
> Eh? lookup_user_key()? That's not necessarily called before, not if you're
> creating a key.

I thought this was generally called before key operations.

For example, sys_add_key() calls it with KEY_WRITE against the destination 
keyring.

> > > This is odd, esp since nothing could have failed between alloc and
> > > publish.  Only state change is serial number.  Would you expect the
> > > security module to update a label based on serial number?
> > 
> > I don't think SELinux would care about this yet.  If so, the hook can be 
> > added later.
> 
> Auditing?

SELinux does not audit object creation, it will sometimes use a _post hook 
to update its internal state or perform the access control check for 
creating the object.


- James
-- 
James Morris
<jmorris@namei.org>
