Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTBEPYt>; Wed, 5 Feb 2003 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTBEPYt>; Wed, 5 Feb 2003 10:24:49 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:51722 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261486AbTBEPYs>; Wed, 5 Feb 2003 10:24:48 -0500
Date: Wed, 5 Feb 2003 15:34:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205153417.A21675@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302051500.KAA05879@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302051500.KAA05879@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Feb 05, 2003 at 10:00:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 10:00:23AM -0500, Stephen D. Smalley wrote:
> No.  If one were to add such a field, then it would be accessible
> through the ctl_table structure that is already passed to the hook.

It would.  But it shouldn't be passed in for the first time.

> You would not replace the ctl_table parameter with the kernel's
> sensitivity hint, since the security module must be able to make its
> own determination as to the protection requirements based on its
> particular security model and attributes.  If you only pass the
> kernel's view of the sensitivity, then you are hardcoding a specific
> policy into the kernel and severely limiting the flexibility of the
> security module.

Yes, and exactly that's the whole point of it!  The problem with LSM
is that it tries to be overly flexible and thus adds random hooks that
expose internal details all over the place.  Just stop that silly no policy
approach and life will get a lot simpler.  There's no reason to implement
everything and a kitchen sink in LSM.

Since the kernel's hint is necessarily independent of
> any particular security model/attributes, it will only provide a
> coarse-grained partitioning, e.g. you are unlikely to be able to
> uniquely distinguish the modprobe variable if you want to specifically
> limit a particular process to modifying it.  The existing hook
> interface does not need to change.

If you need attributes attached to the sysctl nodes just diable sysctl by
number and use the existing filesystem based hooks.

