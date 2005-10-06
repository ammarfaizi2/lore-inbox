Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVJFPSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVJFPSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVJFPSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:18:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751086AbVJFPSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:18:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode> 
References: <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode>  <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 06 Oct 2005 16:18:02 +0100
Message-ID: <30209.1128611882@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > > Access checks seem to be usually done before this point via 
> > > lookup_user_key(), which is ideal.
> > 
> > Eh? lookup_user_key()? That's not necessarily called before, not if you're
> > creating a key.
> 
> I thought this was generally called before key operations.
> 
> For example, sys_add_key() calls it with KEY_WRITE against the destination 
> keyring.

Yes, but not in regard to the new key, which is what I thought you were
implying.

Besides, it's logically two operations: create key and link key to
keyring. The reason they have to be combined is that the key would be
immediately destroyed if it wasn't attached to a keyring.

The permissions check done on the keyring merely assures that the keyring can
be modified, not that a new key may or may not actually be created.

Maybe we're talking at cross-purposes here.

> > > I don't think SELinux would care about this yet.  If so, the hook can be 
> > > added later.
> > 
> > Auditing?
> 
> SELinux does not audit object creation, it will sometimes use a _post hook 
> to update its internal state or perform the access control check for 
> creating the object.

I meant the auditing service. Doesn't that use the security module hooks?

David
