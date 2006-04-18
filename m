Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWDRUmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWDRUmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWDRUmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:42:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32178 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932331AbWDRUmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:42:36 -0400
Date: Tue, 18 Apr 2006 15:42:27 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: T?r?k Edwin <edwin@gurde.com>
Cc: fireflier-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>,
       Crispin Cowan <crispin@novell.com>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Fireflier-devel] Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418204227.GK29302@sergelap.austin.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org> <200604182313.05604.edwin@gurde.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604182313.05604.edwin@gurde.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting T?r?k Edwin (edwin@gurde.com):
> On Tuesday 18 April 2006 22:50, Arjan van de Ven wrote:
> >
> > I would suspect that the "filename" thing will be the biggest achilles
> > heel...
> > after all what does filename mean in a linux world with
> > * hardlinks
> > * chroot
> > * namespaces
> > * bind mounts
> > * unlink of open files
> > * fd passing over unix sockets
> > * relative pathnames
> > * multiple threads (where one can unlink+replace file while the other is
> > in the validation code)
> 
> FYI fireflier v1.1.x created rules based on filenames.
> In the current version we intended to use mountpoint+inode to identify 
> programs. This reduces the potential problems from your list to: fd passing.
> 
> Can't AppArmor use inodes in addition to filenames to implement its rules? 
> The user could still make its choice based on a "filename" (in an interactive 

Doesn't help with, for instance, /etc/shadow.  Run passwd once and the
inode number is obsolete.

So either you find a way to decisively use the pathname to identify it,
or you make sure that anyone who can replace it, labels it.

> - use extended attributes to label files, using selinux's setfiles. Most 
> secure option IMHO

Again, xattrs alone may be insufficient if the file can be replaced.

> - store rules based on mountpoint+inode+program hash/checksum, and then get 
> selinux to label files according to this. Not sure how to do this, and if it 
> is worth at all

Again, you're only addressing initial labeling.  But I guess you're
labeling executables so that should be fine.

-serge
