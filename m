Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWDTN3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWDTN3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWDTN33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:29:29 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:51336 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750937AbWDTN33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:29:29 -0400
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tony Jones <tonyj@suse.de>,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <44468817.5060106@novell.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
	 <1145470230.3085.84.camel@laptopd505.fenrus.org>
	 <44468817.5060106@novell.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:33:13 -0400
Message-Id: <1145536393.3313.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 11:57 -0700, Crispin Cowan wrote:
> Arjan van de Ven wrote:
> > On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> >   
> >> Verify if profile
> >> + * authorizes mask operations on pathname (due to lack of vfsmnt it is sadly
> >> + * necessary to search mountpoints in namespace -- when nameidata is passed
> >> + * more fully, this code can go away).  If more than one mountpoint matches
> >> + * but none satisfy the profile, only the first pathname (mountpoint) is
> >> + * returned for subsequent logging.
> >>     
> > that sounds too bad ;) 
> > If I manage to mount /etc/passwd as /tmp/passwd, you'll only find the
> > later and your entire security system seems to be down the drain.
> >   
> If you are a confined process, then you don't get to mount things, for
> this reason, among others.

Which is an example of the brokenness of the security model - its
fragileness in the face of manipulation of the file tree leads to
inflexibility.  So for example, if you wanted to _protect_ a process
that does mount things as part of its legitimate purpose, e.g. by
limiting what it can access to prevent it from taking untrustworthy
inputs, then you are out of luck - it is either confined and can't mount
or not confined and can mount.

-- 
Stephen Smalley
National Security Agency

