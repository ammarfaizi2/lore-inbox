Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWDTNAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWDTNAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWDTNAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:00:51 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:57087 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750887AbWDTNAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:00:50 -0400
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace
	semaphore
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
In-Reply-To: <20060420124647.GD18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420124647.GD18604@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:05:35 -0400
Message-Id: <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 07:46 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Wed, 2006-04-19 at 10:50 -0700, Tony Jones wrote:
> > > This patch exports the namespace_sem semaphore.
> > > 
> > > The shared subtree patches which went into 2.6.15-rc1 replaced the old
> > > namespace semaphore which used to be per namespace (and visible) with a
> > > new single static semaphore.
> > > 
> > > The reason for this change is that currently visibility of vfsmount information
> > > to the LSM hooks is fairly patchy.  Either there is no passed parameter or
> > > it can be NULL.  For the case of the former,  several LSM hooks that we
> > > require to mediate have no vfsmount/nameidata passed.  We previously (mis)used
> > > the visibility of the old per namespace semaphore to walk the processes 
> > > namespace looking for vfsmounts with a root dentry matching the dentry we were 
> > > trying to mediate.  
> > > 
> > > Clearly this is not viable long term strategy and changes working towards 
> > > passing a vfsmount to all relevant LSM hooks would seem necessary (and also 
> > > useful for other users of LSM). Alternative suggestions and ideas are welcomed.
> > 
> > The alternative I would recommend is to not use LSM.  It isn't suitable
> > for your path-based approach.  If your path-based approach is deemed
> > legitimate, then introduce new hooks at the proper point in processing
> > where the information you need is available.
> 
> Whoa, so now LSM is not for access control?

That isn't what I said, although I see that my phrasing wasn't clear.  I
said it wasn't suitable for a path-based approach.  That is fairly clear
from the hook placements and interfaces, and from the contortions that
AppArmor has to go through in order to obtain the paths, and the number
of times it ends up calling d_path on a single syscall.  Now "new hooks"
_could_ be new LSM hooks, I suppose, but my point was that it is a
mistake to try to use the existing LSM VFS hooks for this purpose - they
are in the wrong place for it, and no amount of munging will fix that.
Make sense?

-- 
Stephen Smalley
National Security Agency

