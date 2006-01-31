Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWAaABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWAaABe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWAaABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:01:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:11500 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965045AbWAaABe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:01:34 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 15/23] [Suspend2] Helper for counting uninterruptible threads of a type.
Date: Tue, 31 Jan 2006 01:02:00 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601302318.28922.rjw@sisk.pl> <20060130222541.GK2250@elf.ucw.cz>
In-Reply-To: <20060130222541.GK2250@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310102.00646.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 30 January 2006 23:25, Pavel Machek wrote:
> On Po 30-01-06 23:18:28, Rafael J. Wysocki wrote:
> > On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> > > 
> > > Add a helper which counts the number of patches of a type (all
> > > or userspace only) which are in TASK_UNINTERRUPTIBLE state.
> > > These tasks are signalled (just in case they leave that state at
> > > a later point), but we do not consider freezing to have failed
> > > if and when they do not enter the freezer.
> > > 
> > > Note that when they eventually leave TASK_UNINTERRUPTIBLE state,
> > > they will enter the refrigerator, but will immediately exit if
> > > we no longer want to freeze at that point.
> > 
> > I think we need to do something like this to prevent problems with
> > freezing under load.
> 
> That is dangerous... task in UNINTERRUPTIBLE may hold some lock,
> AFAICT.

Yes, and we have discussed that already, but frankly I'm still unconvinced. ;-)

> No, there's some simple bug in refrigerator, and I/we need to fix
> that. Signals work under load, so refrigerator should, too.

I don't think there's a bug as such.  The refrigerator is just very simple
and apparently does not cover all possible cases.

I think the problems with freezing tasks are generally related to
uninterruptible processes waiting for events that never happen.

IMHO we can try to defer calling freeze() for kernel threads until all of the
user space processes are frozen.  If that doesn't help, we'll need to treat
uninterruptible tasks in a special way, I'm afraid.

Greetings,
Rafael
