Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWA3W0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWA3W0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWA3WZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:25:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38850 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932390AbWA3WZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:25:59 -0500
Date: Mon, 30 Jan 2006 23:25:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: Re: [ 15/23] [Suspend2] Helper for counting uninterruptible threads of a type.
Message-ID: <20060130222541.GK2250@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034556.3178.79337.stgit@localhost.localdomain> <200601302318.28922.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601302318.28922.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 30-01-06 23:18:28, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> > 
> > Add a helper which counts the number of patches of a type (all
> > or userspace only) which are in TASK_UNINTERRUPTIBLE state.
> > These tasks are signalled (just in case they leave that state at
> > a later point), but we do not consider freezing to have failed
> > if and when they do not enter the freezer.
> > 
> > Note that when they eventually leave TASK_UNINTERRUPTIBLE state,
> > they will enter the refrigerator, but will immediately exit if
> > we no longer want to freeze at that point.
> 
> I think we need to do something like this to prevent problems with
> freezing under load.

That is dangerous... task in UNINTERRUPTIBLE may hold some lock,
AFAICT.

No, there's some simple bug in refrigerator, and I/we need to fix
that. Signals work under load, so refrigerator should, too.

							Pavel
-- 
Thanks, Sharp!
