Return-Path: <linux-kernel-owner+w=401wt.eu-S1947255AbWLHVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947255AbWLHVQe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947253AbWLHVQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:16:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48926 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947252AbWLHVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:16:32 -0500
Date: Fri, 8 Dec 2006 15:16:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] file capabilities: two bugfixes
Message-ID: <20061208211626.GA30754@sergelap.austin.ibm.com>
References: <20061208193657.GB18566@sergelap.austin.ibm.com> <402572.41716.qm@web36607.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402572.41716.qm@web36607.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Casey Schaufler (casey@schaufler-ca.com):
> 
> --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > ...
> > The other is that root can lose capabilities by
> > executing files with
> > only some capabilities set.  The next two patches
> > change these
> > behaviors.
> 
> It was the intention of the POSIX group that
> capabilities be independent of uid. I would
> argue that the old bevavior was correct, that
> a program marked to lose a capability ought
> to even if the uid is 0.

Agreed, and if SECURE_NOROOT is set, that is what happens.
But by default SECURE_NOROOT is not set, in which case linux's
implementation of capabilities behaves differently for root.

Without this latest patch, with SECURE_NOROOT not set, what was
actually happening was that the kernel behaved as though
SECURE_NOROOT was not set so long as there was no
security.capability xattr, and always behaved as though
SECURE_NOROOT was set if there was an xattr.  That's inconsistent
and confusing behavior.

The worst part is that root can get around running the code
with limited caps by just copying the file and running the
copy.  So it adds no security benefit, and adds an
inconsistency/complication which could cause security risks.

-serge
