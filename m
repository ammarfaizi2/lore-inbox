Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268788AbUIHBk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268788AbUIHBk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 21:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUIHBk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 21:40:28 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:55980 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268788AbUIHBkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 21:40:24 -0400
In-Reply-To: <200409072102.i87L2K4u005503@laptop11.inf.utfsm.cl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: silent semantic changes with reiser4 
Cc: spam@tnonline.net, christer@weinigel.se, ninja@slaphack.com,
       tonnerre@thundrix.ch, torvalds@osdl.org, pavel@ucw.cz,
       jamie@shareable.org, cw@f00f.org,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com, reiser@namesys.com
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Tue, 07 Sep 2004 21:38:31 -0400 EDT
Message-Id: <89861950490-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote on Tue, 07 Sep 2004 17:02:20 -0400:
> Hans Reiser <reiser@namesys.com> said:
> > Or, we can ask Alexander to help us use his deadlock detection algorithm 
> > and try to do things right....
> 
> Good luck with that one. I'd suspect if it can be made to work, it will
> have _huge_ overhead, so much that it is useless. I'd love to be proven
> wrong, but I won't hold my breath.

Depends if you consider it to be a huge overhead to lock all the objects
that are ancestors (possibly through cyclical multiple parents) of the
fildirute (file/directory/attribute/whatever) being deleted/renamed.
It could definitely be a lot if you have some weird worst case directory
layout with lots of parent directories.  But that's rare (most users
don't have that many directories anyway).

By the way, the deadlock system I was using is just a hack - a timeout
on the locking semaphores for each file.  If it fails to lock everything
it needs, it backs off, waits a while, tries again, and eventually
reports EDEADLK if it exhausts the retry count.

Well, actually it's a bit fancier - it read-locks the file nodes as it
is traversing the graph to find all ancestors.  Then when it has finished,
it write-locks the ones it needs to change.

- Alex
