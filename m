Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131723AbRAKQPV>; Thu, 11 Jan 2001 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132356AbRAKQPM>; Thu, 11 Jan 2001 11:15:12 -0500
Received: from hermes.mixx.net ([212.84.196.2]:13316 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131723AbRAKQPA>;
	Thu, 11 Jan 2001 11:15:00 -0500
Message-ID: <3A5DDB4D.8BDAA281@innominate.de>
Date: Thu, 11 Jan 2001 17:11:57 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
In-Reply-To: <3A5A4958.CE11C79B@goingware.com> <3A5B0D0C.719E69F@innominate.de> <20010110115632.E30055@pcep-jamie.cern.ch> <3A5DC376.D9E5103F@innominate.de> <20010111163703.A3000@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Daniel Phillips wrote:
> >         DN_OPEN       A file in the directory was opened
> >
> > You open the top level directory and register for events.  When somebody
> > opens a subdirectory of the top level directory, you receive
> > notification and register for events on the subdirectory, and so on,
> > down to the file that is actually modified.
> 
> If it worked, and I'm not sure the timing would be reliable enough, the
> daemon would only have to have open every directory being accessed by
> every program in the system.  Hmm.  Seems like overkill when you're only
> interested in files that are being modified.

It gets to close some too.  Normally just the directories in the path to
the file(s) being modified would be open.

Good point about the timing.  A directory should not disappear before an
in-flight notification has been serviced.  I doubt the current scheme
enforces this.  There is no more room for 'works most of the time' in
this than there is in our memory page handling.

> It would be much, much more reliable to do a walk over d_parent in
> dnotify.c.  Your idea is a nice way to flag kernel dentries such that
> you don't do d_parent walks unnecessarily.

It's bottom-up vs top-down.  It's worth analyzing the top-down approach
a little more, it does solve a lot of problems (and creates some as you
pointed out, or at least makes some existing problems more obvious). 
For make it's really quite nice.  The make daemon only needs to register
in the top level directory of the source tree.  I think this solves the
hard link problem too, because each path that's interested in
notification will receive it.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
