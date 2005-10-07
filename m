Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVJGJKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVJGJKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVJGJKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:10:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751028AbVJGJKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:10:13 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051006175817.GK16352@shell0.pdx.osdl.net> 
References: <20051006175817.GK16352@shell0.pdx.osdl.net>  <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com> 
To: Chris Wright <chrisw@osdl.org>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 10:10:05 +0100
Message-ID: <21866.1128676205@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:

> The security check is comparing key label to task label.  If it's not
> done 100% in current context, then task must be passed to get access
> to proper label.  So, for example, request-key is done by the special
> privileged /sbin/request-key via usermodehelper on behalf of someone else.

Which task(s)? Both the one doing the check, and the one on whose behalf the
check is done?

> > Auditing?
> 
> Hmm, suppose, but auditing is not the charter of LSM.  So in this case,
> the previous hook can audit key creation if needed.  Just looking to
> avoid hook proliferation if possible.

But you don't know the key serial number at that point, hence why I added the
second hook. I'll drop the second. I can always bring it back later.

> > That's what I was thinking of.
> 
> I see, what would they used for?

I don't know. As far as I know, setxattr and co can be used to set and
retrieve security data on files. I thought it would be desirable to have
similar for keys. If not, I can remove both calls/hooks for the time being.

David
