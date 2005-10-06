Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJFQDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJFQDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJFQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:03:00 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:38119 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751125AbVJFQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:02:59 -0400
Date: Thu, 6 Oct 2005 12:02:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Steve Grubb <sgrubb@redhat.com>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
In-Reply-To: <30209.1128611882@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510061148250.26937@excalibur.intercode>
References: <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode> 
 <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode>
 <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net>
 <23333.1128596048@warthog.cambridge.redhat.com>  <30209.1128611882@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, David Howells wrote:

> > For example, sys_add_key() calls it with KEY_WRITE against the destination 
> > keyring.
> 
> Yes, but not in regard to the new key, which is what I thought you were
> implying.
> 
> Besides, it's logically two operations: create key and link key to
> keyring. The reason they have to be combined is that the key would be
> immediately destroyed if it wasn't attached to a keyring.

I had assumed that you didn't want a permission check just for creating a 
key (which is a fairly abstract and inert thing if you don't do anything 
with it), and were only wanting to peform a check when linking.

> The permissions check done on the keyring merely assures that the keyring can
> be modified, not that a new key may or may not actually be created.

Ok, time to add KEY_CREATE?

> > > > I don't think SELinux would care about this yet.  If so, the hook can be 
> > > > added later.
> > > 
> > > Auditing?
> > 
> > SELinux does not audit object creation, it will sometimes use a _post hook 
> > to update its internal state or perform the access control check for 
> > creating the object.
> 
> I meant the auditing service. Doesn't that use the security module hooks?

LSM is supposed to be about access control only, although SELinux and 
Audit are becoming more intimate as time passes.

[added Steve Grubb to the cc list, who is looking at LSPP audit 
requirements]



- James
-- 
James Morris
<jmorris@namei.org>
