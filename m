Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTKKPBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTKKPBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:01:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62857
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263528AbTKKPBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:01:22 -0500
Date: Tue, 11 Nov 2003 16:00:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111150050.GD1649@x30.random>
References: <20031111034815.GA17240@pegasys.ws> <Pine.LNX.4.44.0311102323240.980-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311102323240.980-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:34:18PM -0800, Davide Libenzi wrote:
> On Mon, 10 Nov 2003, jw schultz wrote:
> 
> > If not you can test the directory.
> > 
> >         ls -l $CVSROOT/CVSROOT >$TMPFILE.start
> >         touch $TMPFILE.test
> > 
> >         until diff -q $TMPFILE.start $TMPFILE.test >/dev/null
> >         do
> > 		ls -l $CVSROOT/CVSROOT >$TMPFILE.start
> >                 rsync .....
> >                 ls -l $CVSROOT/CVSROOT >$TMPFILE.test
> >         done
> >         rm -f $TMPFILE.start $TMPFILE.test
> 
> It does not work either. If CVSROOT files are updated at the end, you can 
> still fetch some new files and be able to fetch the old CVSROOT before the 
> update process will be able to do it. I believe that the LOCK file idea 
> should work pretty nicely. The update process goes like:
> 
> create LOCK
> update repo
> remove LOCK
> 
> While the client can simply:
> 
> do
>     rsync
> while exist LOCK

that can't work either, the client can't take the lock, rsync is a
readonly thing. the create lock update repo, remove lock will all three
run during the client rsync. the "exist LOCK" will never notice.

unless you want to use snapshots etc.. the seq lock is the only viable
way to checkout coherent with rsync.

hope this isn't going too offtopic for l-k though.
