Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWGaRqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWGaRqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWGaRqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:46:32 -0400
Received: from mail.teleformix.com ([12.15.20.75]:57735 "EHLO
	mail.teleformix.com") by vger.kernel.org with ESMTP
	id S1030287AbWGaRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:46:31 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Dan Oglesby <doglesby@teleformix.com>
Reply-To: doglesby@teleformix.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20060731171620.GL31121@lug-owl.de>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	 <20060731144736.GA1389@merlin.emma.line.org>
	 <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <20060731162224.GJ31121@lug-owl.de> <1154364421.7964.22.camel@localhost>
	 <20060731171620.GL31121@lug-owl.de>
Content-Type: text/plain
Organization: Teleformix, LLC
Date: Mon, 31 Jul 2006 12:44:22 -0500
Message-Id: <1154367862.7964.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 19:16 +0200, Jan-Benedict Glaw wrote:
> On Mon, 2006-07-31 11:47:00 -0500, Dan Oglesby <doglesby@teleformix.com> wrote:
> > On Mon, 2006-07-31 at 18:22 +0200, Jan-Benedict Glaw wrote:
> > > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> > > > A colleague of mine happened to create a ~300gb filesystem and started
> > > > to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
> > > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> > > So preparation work wasn't done.
> > 
> > As someone who is currently planning to migrate ~100GB of stored mail to
> > the Maildirs format, it was pretty clear early on that EXT3 would not
> > cut it (from past and current experiences), and not just for the sake of
> > calculating inodes.
> 
> Uh?  Where did you face a problem there?
> 

Past experiences dealing with systems that generate several thousand to
tens of thousands of files a day, adding up to well in the millions over
the course of normal production (this is not for a mail server, BTW).
Once we got close to a million files, filesystem transactions started
bogging the system, driving the load over 50.  Simply switching to
ReiserFS v3 allowed us to go well past the number of files EXT3 could
handle reasonably and the max load stayed right around the number of
CPUs the system contained (typically 8).

There is a LOT going on with these systems, not just filesystem
transactions.  EXT3 does not do well in our environment at all.

> With maildir, you shouldn't face any problems IMO. Even users with
> zillions of mails should work properly with the dir_index stuff:
> 
> 	tune2fs -O dir_index /dev/hdXX
> 
> or alternatively (to start that for already existing directories):
> 
> 	e2fsck -fD /dev/hdXX
> 
> 

I've been tuning EXT3 to see what performance I can get for the mail
server, and it's just not there compared to ReiserFS with minimal
tuning.

> Of course, you'll always face a problem with lots of files in one
> directory at getdents() time (eg. opendir()/readdir()/closedir()), but
> this is a common limit for all filesystems.
> 
> MfG, JBG
> 

Of course, but the issue is EXT3 does this a whole lot worse than
ReiserFS v3 from my experiences.

At any rate, that's about all I have to say about this issue.  I'll be
patiently waiting to see ReiserFS v4 included in the main kernel, so I
have less hoops to jump through to implement the latest and greatest
from Namesys.

--Dan

