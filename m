Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWDRUXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWDRUXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDRUXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:23:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:32160 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932324AbWDRUX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:23:29 -0400
Date: Tue, 18 Apr 2006 15:23:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Crispin Cowan <crispin@novell.com>, Karl MacMillan <kmacmillan@tresys.com>,
       Gerrit Huizenga <gh@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418202323.GI29302@sergelap.austin.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com> <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145389813.2976.47.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
> > Karl MacMillan wrote:
> > > Which is one reason why SELinux has types (equivalence classes) - it
> > > makes it possible to group large numbers of applications or resources
> > > into the same security category. The targeted policy that ships with
> > > RHEL / Fedora shows how this works in practice.
> > >   
> > AppArmor (then called "SubDomain") showed how this worked in practice
> > years before the Targeted Policy came along. The Targeted Policy
> > implements an approximation to the AppArmor security model, but does it
> > with domains and types instead of path names, imposing a substantial
> > cost in ease-of-use on the user.
> 
> I would suspect that the "filename" thing will be the biggest achilles
> heel...
> after all what does filename mean in a linux world with
> * hardlinks
> * chroot
> * namespaces
> * bind mounts
> * unlink of open files
> * fd passing over unix sockets
> * relative pathnames
> * multiple threads (where one can unlink+replace file while the other is
> in the validation code)

My old dte module addressed all of these by keeping an in-kernel map
of vfsmounts.  Ok, all the interesting ones - three of them are
solved just by appropriately using file->f_security.

Hardlinks are a pain, but you just have to make up your mind how to
solve them.  In selinux (i believe) the solution is "the first name to
match a rule wins" during labeling, and of course at run-time the labels
are taken from xattrs, and newly created files are based on parent dir
and creating process.  It may be solved in selinux, but since at some
point all initial files must be labeled based on pathname, it still is
an issue to be addressed.

I am curious to see how subdomain will solve these.  And LIDS.  Have
they switched to a install-time xattr labeling + file transition rules
scheme like selinux?  We'll see, it could be interesting.  (Or, it could
be uninteresting and completely wrong...)

-serge
