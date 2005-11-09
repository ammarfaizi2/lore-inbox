Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVKISoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVKISoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVKISoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:44:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53122 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751493AbVKISoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:44:37 -0500
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
	 <1131464926.5400.234.camel@localhost>
	 <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131561849.5400.384.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Nov 2005 10:44:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 07:55, Miklos Szeredi wrote:
> > No. As explained in the same earlier threads; without this change the
> > behavior of shared-subtrees leads to inconsistency and confusion in some
> > scenarios.
> > 
> > Under the premise that no application should depend on this behavior
> > (most-recent-mount-visible v/s top-most-mount-visible),
> 
> The strongest argument against was that
> 
>   mount foo .; umount .
> 
> would no longer be a no-op.

It is a no-op even now.  Try it.

What you meant was something like this is no-op now?

P1: cd /tmp1
P2: mount --bind /var /tmp1
P1: mount --bind /bin .
P1: umount .
 
Yes this will not be a noop with my changes. However this behavior is
not documented to be a no-op anywhere. right? And 'umount .' really
doen't make sense. What does it mean? umount  the current mount? or
umount of the mount that is mounted on this dentry?

My changes just changes one behavior and that is:
If multiple mounts are mounted on the same <mount,dentry> combination
the later mounts are obscured by the preceeding mounts. Earlier it was
opposite behavior.

My biggest complaint about the earlier behavior was that the later
mounts obscured not only the earlier mounts on the <mount,dentry> tuple,
but also obscured all the mounts that got stacked on top of the
earlier <mount,dentry>.  It seemed totally unnatural, and confusing
with shared-subtree.  


> > Al Viro permitted this change. And this is certainly the right
> > behavior.
> 
> Which is a contradiction in term, since you are saying that
> applications _do_ depend on it.

no. I said application _should_not_ depend on it, because it is a
undefined semantics.

Sorry I was out yesterday and could reply earlier.
RP

> 
> Miklos

