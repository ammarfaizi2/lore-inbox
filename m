Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDSLxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDSLxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWDSLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:53:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64226 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750705AbWDSLxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:53:42 -0400
Date: Wed, 19 Apr 2006 06:53:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, ericvh@hera.kernel.org
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419115336.GD20481@sergelap.austin.ibm.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kyle Moffett (mrmacman_g4@mac.com):
> On Apr 18, 2006, at 21:48:56, Casey Schaufler wrote:
> >--- James Morris <jmorris@namei.org> wrote:
> >>With pathnames, there is an unbounded and unknown number of  
> >>effective security policies on the system, as there are an
> >>unbounded and unknown number of ways of viewing the files via  
> >>pathnames.
> >
> >I agree that for traditional DAC and MAC (including the flavors  
> >supported by SELinux) inodes is the only way to go. SELinux is a  
> >traditional Trusted OS architecture and addresses the traditional  
> >Trusted OS issues.
> 
> Perhaps the SELinux model should be extended to handle (dir-inode,  
> path-entry) pairs.  For example, if I want to protect the /etc/shadow  
> file regardless of what tool is used to safely modify it, I would set  
> up security as follows:

Perhaps linux should keep it's momentum toward p9-ish and implement a
factotum service.

Note what we're trying to do:
	1. make the mount tree as dynamic as possible, per-process.
	So my /var/spool can be completely different from yours,
	on the same machine.
	2. but to let process p5 authenticate as root, privileged code
	trusts info stored in hardcoded pathnames in p5's current mount
	tree.
In other words, we want to prevent just a few pathnames from being
replaced through a bind mount/pivot_root/whatever.

Would make much more sense to have one thread running in an initial
private fs namespace, using pathnames it knows it can trust to dole
out privs.

I recall at last year's OLS Eric Van Hensbergen led a talk to discuss
problems involved in allowing unprivileged user mounts, where this
idea came up.  But of course no one (that I know of) has been crazy
enough to try it.

-serge
