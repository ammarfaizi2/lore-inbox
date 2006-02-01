Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWBAAc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWBAAc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBAAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:32:29 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46468 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932312AbWBAAc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:32:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Wed, 1 Feb 2006 01:33:08 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601311158.16882.rjw@sisk.pl> <200602010921.09750.nigel@suspend2.net>
In-Reply-To: <200602010921.09750.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010133.08720.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 01 February 2006 00:21, Nigel Cunningham wrote:
> On Tuesday 31 January 2006 20:58, Rafael J. Wysocki wrote:
> > Hi,
> > > > >
> > > > > +	if (freezer_is_on())
> > > > > +		return 0;
> > > > > +
> > > > >  	if (path[0] == '\0')
> > > > >  		return 0;
> > > >
> > > > Disabling the usermode helper while freeze_processes() is executed
> > > > seems to be a good idea to me, but I think it should be done with a
> > > > mutex or something like that.
> > >
> > > With the refrigerator code you guys are using at the moment, ouldn't that
> > > result in deadlocks when we later try to freeze the process in
> > > preparation for the atomic restore? (Or perhaps you don't freeze
> > > processes at that point?)
> >
> > I'm not sure what you mean.  I said "mutex" because you seem to have a race
> > here (the freezer may be started right after the freezer_is_on() check). 
> > IMO the freezer should disable the invocations of new usermode helpers and
> > wait util all of the already running helpers are finished.  For this
> > purpose two variables would be needed and a lock.
> 
> Sorry. Being a bit thick.
> 
> I wasn't worried about already-running usermode helpers (or about-to-run 
> helpers either) because the spawned processes would either complete or be 
> caught be the usual freezing code. My concern was more that new invocations 
> of this path don't leave us with unfrozen processes hanging around. That 
> said, I think you have a valid point about letting existing helpers run to 
> completion. It does make me concerned though about the possibility of a 
> long-lived helper (not that I know that there really are such things at the 
> moment). Do you think that needs to be taken as a genuine concern? If so, I 
> guess we then need to make freezing a four stage process:
> 
> 1. Stop new usermodehelpers from starting & let existing ones run to 
> completion.
> 2. Freeze userspace.
> 3. Freezer bdevs.
> 4. Freezer kernel space.

Well, I know a little about bdevs, but generally I think that's reasonable.

Greetings,
Rafael
