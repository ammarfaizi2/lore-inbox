Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbRAKOdr>; Thu, 11 Jan 2001 09:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRAKOdS>; Thu, 11 Jan 2001 09:33:18 -0500
Received: from hermes.mixx.net ([212.84.196.2]:19471 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129810AbRAKOdQ>;
	Thu, 11 Jan 2001 09:33:16 -0500
Message-ID: <3A5DC376.D9E5103F@innominate.de>
Date: Thu, 11 Jan 2001 15:30:14 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
In-Reply-To: <3A5A4958.CE11C79B@goingware.com> <3A5B0D0C.719E69F@innominate.de> <20010110115632.E30055@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Daniel Phillips wrote:
> > [things that can benefit from dnotify]
> > locate (reindex only those directories that have changed, keep index
> > database current).
> 
> Not a chance.  dnotify doesn't work recursively, so you can't monitor
> just a few top level directories like "/usr/lib".  And have you ever
> tried to keep all 3000 directories on your filesystem directories open
> at the same time?  Would you want to consume that much non-swappable
> memory, and also prevent the directories from being removed from the
> filesystem?
> 
> Long ago I proposed something similar that works at the disk level, is
> recursive, and the checks can be done without keeping directories open.
> But I never wrote the code :(  That's interesting because it speeds up
> make without needing a daemon, and really can speed up
> locate/updatedb/find.

It took a little while for the following to dawn on me: it's not hard to
make the dnotify scheme work recursively and you don't have to keep 3000
directories open.  To modify a file you must have opened all the
directories in its path.  We need a new event: 

        DN_OPEN       A file in the directory was opened

You open the top level directory and register for events.  When somebody
opens a subdirectory of the top level directory, you receive
notification and register for events on the subdirectory, and so on,
down to the file that is actually modified.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
