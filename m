Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWDTMqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDTMqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDTMqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:46:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:40347 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750720AbWDTMqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:46:50 -0400
Date: Thu, 20 Apr 2006 07:46:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
Message-ID: <20060420124647.GD18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2006-04-19 at 10:50 -0700, Tony Jones wrote:
> > This patch exports the namespace_sem semaphore.
> > 
> > The shared subtree patches which went into 2.6.15-rc1 replaced the old
> > namespace semaphore which used to be per namespace (and visible) with a
> > new single static semaphore.
> > 
> > The reason for this change is that currently visibility of vfsmount information
> > to the LSM hooks is fairly patchy.  Either there is no passed parameter or
> > it can be NULL.  For the case of the former,  several LSM hooks that we
> > require to mediate have no vfsmount/nameidata passed.  We previously (mis)used
> > the visibility of the old per namespace semaphore to walk the processes 
> > namespace looking for vfsmounts with a root dentry matching the dentry we were 
> > trying to mediate.  
> > 
> > Clearly this is not viable long term strategy and changes working towards 
> > passing a vfsmount to all relevant LSM hooks would seem necessary (and also 
> > useful for other users of LSM). Alternative suggestions and ideas are welcomed.
> 
> The alternative I would recommend is to not use LSM.  It isn't suitable
> for your path-based approach.  If your path-based approach is deemed
> legitimate, then introduce new hooks at the proper point in processing
> where the information you need is available.

Whoa, so now LSM is not for access control?

Of course if SuSE follows Al Viro's suggestion of using namespaces
(effectively using capabilities in their traditional sense), they'll use
fewer hooks, but they'll still need to prevent leaking of fd's accross
namespaces, for instance.

-serge
