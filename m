Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946987AbWKARqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946987AbWKARqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946985AbWKARqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:46:32 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:42148 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1946987AbWKARq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:46:28 -0500
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmill@redhat.com>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <1162396705.29617.18.camel@localhost.localdomain>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
	 <1162396705.29617.18.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 01 Nov 2006 12:45:34 -0500
Message-Id: <1162403134.32614.242.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 10:58 -0500, Karl MacMillan wrote:
> I suggested change instead of transition because, like most uses of
> change, this was a manual relabel rather than automatic. Transition
> probably makes more sense, though.

Yes, if we need it at all.

> This is all predicated on the notion that there is a need to have the
> normal SELinux checks performed. Since this serves only as a sanity
> check and doesn't add any real security the best option seems bypass,
> but I guess that isn't an option.

"Bypass" in the sense of directly calling the inode ops rather than the
vfs helpers is undesirable.  "Bypass" in the sense of temporarily
setting a task flag indicating that permission checking should be
disabled for an internal access attempt seems ok.

> fssid seems like the wrong name, though it does match the DAC concept.
> This is really more general impersonation of another domain by the
> kernel and might have other uses.

NFS will want a fssid in order to have file access checks applied
against the client process' SID if/when the client process' context
becomes available.  But it isn't really necessary here as far as I can
see; the cachefiles module is not trying to act on behalf of a task, but
instead is performing an internal access to local cache that should
always succeed, and the usual permission checking for userspace is
handled by the fs before cachefiles is called.

-- 
Stephen Smalley
National Security Agency

