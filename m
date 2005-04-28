Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVD1Tqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVD1Tqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVD1Tqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:46:39 -0400
Received: from pat.uio.no ([129.240.130.16]:41412 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262220AbVD1Tq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:46:27 -0400
Subject: Re: [PATCH] private mounts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: 7eggert@gmx.de, Andrew Morton <akpm@osdl.org>, bulb@ucw.cz,
       hch@infradead.org, jamie@shareable.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
       Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <OFF95431C8.830FB697-ON88256FF1.006112B7-88256FF1.0062D7C3@us.ibm.com>
References: <OFF95431C8.830FB697-ON88256FF1.006112B7-88256FF1.0062D7C3@us.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 15:46:07 -0400
Message-Id: <1114717567.11547.82.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.857, required 12,
	autolearn=disabled, AWL 1.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 28.04.2005 Klokka 10:58 (-0700) skreiv Bryan Henderson:
> >This is why you have identity squashing and/or strong security: to stop
> >the CLIENT administrator impersonating whoever he wants and working
> >around your security measures.
> 
> That's more of a confirmation than a refutation of the statement that NFS 
> root squashing is broken.  Root squashing itself simply does not squash a 
> typical system administrator's ability to get at other people's files. 
> "broken" isn't the right word, because as long as you recognize root 
> squashing for what it is, it's working as designed.  It just isn't what it 
> appears to be.

Root squashing is there to enforce the policy that nobody gets to access
any files with uid=0,gid=0. IOW it is a policy that is first and
foremost meant to make root-owned files untouchable.

Strong security, OTOH, enforces the policy that you need to authenticate
as a given person in order to get at that person's files.

Neither can prevent man-in-the-middle style attacks by root on a client
that is compromised nor can they stop someone who has managed to lift
your username+password from somewhere. Every security policy has its
limitations.

> But, in the context of the current thread, I think the perception of NFS 
> root squashing as something broken and not to be built upon with private 
> mounts has to do with the fact that it messes up Linux's basic file 
> permission scheme:  a process with CAP_DAC_OVERRIDE can get EACCES. 
> EACCESS means discretionary access controls (DAC) prevent access.  So this 
> behavior is unexpected and unnatural.  Worse, an operation can succeed 
> _without_ CAP_DAC_OVERRIDE, but not _with_ it.  I've seen this behavior 
> cause trouble a number of times -- mostly because it's entirely 
> unanticipated.

Tough. Your administrator has set a certain policy on the fileserver,
and it is being correctly enforced. If that policy decision turns out to
be unnecessarily strict then you are quite free to plead with the
administrator to change it.

Note that these days CAP_DAC_OVERRIDE is no longer guaranteed to be
sufficient even for local disk if the administrator is using LSE to set
up custom policies.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

