Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVJGSvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVJGSvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbVJGSvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:51:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030277AbVJGSvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:51:31 -0400
Date: Fri, 7 Oct 2005 11:51:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
Message-ID: <20051007185121.GS16352@shell0.pdx.osdl.net>
References: <20051006175817.GK16352@shell0.pdx.osdl.net> <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com> <21866.1128676205@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21866.1128676205@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> 
> > The security check is comparing key label to task label.  If it's not
> > done 100% in current context, then task must be passed to get access
> > to proper label.  So, for example, request-key is done by the special
> > privileged /sbin/request-key via usermodehelper on behalf of someone else.
> 
> Which task(s)? Both the one doing the check, and the one on whose behalf the
> check is done?

Sorry, the one who initiated the request, so rka->context in this case
(the one on whose behalf the check is done).

> > > Auditing?
> > 
> > Hmm, suppose, but auditing is not the charter of LSM.  So in this case,
> > the previous hook can audit key creation if needed.  Just looking to
> > avoid hook proliferation if possible.
> 
> But you don't know the key serial number at that point, hence why I added the
> second hook. I'll drop the second. I can always bring it back later.

You'll know the serial number any time an action is taken on the key,
and that's auditable.  I agree, if we find a need it can certainly be
resurrected.

> > > That's what I was thinking of.
> > 
> > I see, what would they used for?
> 
> I don't know. As far as I know, setxattr and co can be used to set and
> retrieve security data on files. I thought it would be desirable to have
> similar for keys. If not, I can remove both calls/hooks for the time being.

Right, that makes sense considering that data is stored on disk and
likely needs to be initialized at some point by an admin or install.
Keys are transient and I'd expect policy engine to label them when
created.  Looks like Stephen sees a use, so perhaps just dropping
surrounding conditional logic and letting module handle it same as
setxattr case.

thanks,
-chris
