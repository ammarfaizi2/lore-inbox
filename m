Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWDRX5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWDRX5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWDRX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:57:22 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:65223 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750861AbWDRX5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:57:21 -0400
Date: Tue, 18 Apr 2006 19:57:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Crispin Cowan <crispin@novell.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <4445719E.8020300@novell.com>
Message-ID: <Pine.LNX.4.64.0604181933290.29123@d.namei>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> 
 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>  <44453E7B.1090009@novell.com>
 <1145391969.21723.41.camel@localhost.localdomain> <444552A7.2020606@novell.com>
 <Pine.LNX.4.64.0604181709160.28128@d.namei> <4445719E.8020300@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, Crispin Cowan wrote:

> >> SELinux has NSA legacy, and that is reflected in their inode design: it
> >> is much better at protecting secrecy, which is the NSA's historic
> >> mission.
> >>     
> > No.  The inode design is simply correct.
> >   
> "Correct" for what? inode access control is correct if data secrecy is
> your number one objective. It is not necessarily correct for other purposes.

It's correct for deterministically and safely applying security policy 
when accessing a file.

With pathnames, there is an unbounded and unknown number of effective 
security policies on the system, as there are an unbounded and unknown 
number of ways of viewing the files via pathnames.

> > What if Unix DAC security was implemented via pathnames, using a 
> > configuration file and regexp matching enginer in the kernel, invoked 
> > during file access, rather than the existing scheme of checking inode 
> > ownership and permission attributes?
> >   
> What of it? That sounds very close to the AppArmor design, except for
> the "discretionary" part. Just what is wrong with it? If your main
> complaint is that you would miss having chmod and umask, then I agree:
> we are not proposing to remove classic DAC. So what's your point?

The point is to illustrate the basic AppArmor mechanism, using a security 
model which people already know and understand.


> > SELinux labels objects directly because it's the right thing to do.
> >   
> Security design by Wilford Brimley: emphatic assertion :)

As Arjan already pointed out, pathname security doesn't work for:

* hardlinks
* chroot
* namespaces
* bind mounts
* unlink of open files
* fd passing over unix sockets
* relative pathnames
* multiple threads (where one can unlink+replace file while the other is
  in the validation code)


Direct object labeling is the only mechanism which allows you to perform 
reliable access control checks against those objects.


> However, I assert (emphatically :) that the broader user community has
> integrity and availability as higher priorities than secrecy, and that
> pathname-based access control is a better way to achieve that.

Integrity control is a fundamental aspect of SELinux, implemented via Type 
Enforcement.  Please refer to:

  W. Boebert and R. Yain. "A Practical Alternative to Hierarchical 
  Integrity Policies." In Proceedings National Computer Security 
  Conference, 1985.


> I want to offer Linux users the choice of pathname-based access control 
> if they want it. Why do you want to prevent them from having that 
> choice?

My opinion is that it's fundamentally broken as the core mechanism of an 
access control mechanism, although there are places where it can make 
sense.

All I'm doing at this stage is responding to your comments on SELinux, as 
unfortunately, from prior experience, if they go unchallenged, many people 
will believe them to be correct.



- James
-- 
James Morris
<jmorris@namei.org>
