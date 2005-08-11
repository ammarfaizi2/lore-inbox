Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVHKJ06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVHKJ06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVHKJ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:26:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932294AbVHKJ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:26:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508110812.59986.phillips@arcor.de> 
References: <200508110812.59986.phillips@arcor.de>  <42F57FCA.9040805@yahoo.com.au> <200508090724.30962.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> 
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 11 Aug 2005 10:26:30 +0100
Message-ID: <26569.1123752390@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:

> 
> This filesystem-specific flag needs to be prevented from escaping into other
> subsystems that might interact, such as VM.  The current usage is mainly
> for directories, except for Reiser4, which uses it for journalling
> ..
> +	SetPageMiscFS(page);

Can you please retain the *PageFsMisc names I've been using in my stuff?

In my opinion putting the "Fs" bit first gives a clearer indication that this
is a bit exclusively for the use of filesystems in general.

> +#define PG_fs_misc		 8	/* don't let me spread */

Should perhaps be:

  +#define PG_fs_misc		 8	/* for internal filesystem use only */

> and NFS, which presses it into service in a network cache coherency role.

The patches to make the AFS filesystem use it were removed, pending a release
of updated filesystem caching patches.

The NFS filesystem patches that use it haven't yet found there way into
Andrew's tree, but are also being held pending FS-Cache being updated.

If you wish, I will send the FS-Cache patch, the AFS patch and the NFS patch
to Andrew so that you can see. CacheFS needs more work, however, before that
can be re-released.

David
