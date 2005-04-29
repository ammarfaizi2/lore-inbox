Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVD2Ag3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVD2Ag3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVD2Ag3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:36:29 -0400
Received: from pat.uio.no ([129.240.130.16]:63119 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262358AbVD2AgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:36:13 -0400
Subject: Re: [PATCH] private mounts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: 7eggert@gmx.de, Andrew Morton <akpm@osdl.org>, bulb@ucw.cz,
       hch@infradead.org, jamie@shareable.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
       Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <OFAECB8B29.CBF40C89-ON88256FF1.00790823-88256FF1.007C85B5@us.ibm.com>
References: <OFAECB8B29.CBF40C89-ON88256FF1.00790823-88256FF1.007C85B5@us.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 20:35:51 -0400
Message-Id: <1114734951.9738.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.518, required 12,
	autolearn=disabled, AWL 1.48, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 28.04.2005 Klokka 15:38 (-0700) skreiv Bryan Henderson:
> >Root squashing is there to enforce the policy that nobody gets to access
> >any files with uid=0,gid=0. IOW it is a policy that is first and
> >foremost meant to make root-owned files untouchable.
> 
> That's the only thing it does well, but you'd have to convince me that 
> that's what it was designed for and that's what everyone expects out of 
> it.  The most salient effect of root squashing -- the one that takes 
> people by surprise -- is that it removes the special rights an NFS server 
> otherwise accords to uid 0.  If protecting files owned by uid=0, gid=0 
> were the original design goal, the protocol could have been designed to do 
> that while still giving uid 0 access to everybody else's files.

That is much harder to do. The nfs server would have to take over the
permissions checking on behalf of whatever it is exporting for all
operations.

> >>a process with CAP_DAC_OVERRIDE can get EACCES.  ... Whine, whine...
> >Tough.
> 
> This is actually off-topic.  We're not talking about whether root 
> squashing is a good compromise.  We started with the statement that the 
> only existing thing like (some private mount proposal) is NFS root 
> squashing and the statement that some people consider that broken.  That 
> elicited a response from you that suggested you were unaware there was 
> anything not to like about root squashing ("Really?") and then some 
> descriptions of the objections.  The fact is that negative perceptions of 
> root squashing exist.  I know you know that.  There are respectable 
> technical people who don't agree with the compromise.  So if one is 
> looking for a broadly acceptable design of private mounts, one might want 
> to find one that doesn't use NFS root squashing as its precedent.

The lack of agreement on root squashing is a reason for it to be a
matter of administrator-defined policy, and why the solution chosen
_should_ allow for that kind of behaviour.

If the user is free to futz around with the namespace, then it makes a
lot of sense for administrators to want to restrict access to this
user-defined namespace to non-suid programs that won't start screwing
round with opening files on arbitrary filesystems using the wrong
credentials and/or capabilities.
Particularly so if the user is capable of mounting remote filesystems.

Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

