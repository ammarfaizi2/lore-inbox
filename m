Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRADIDU>; Thu, 4 Jan 2001 03:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRADIDL>; Thu, 4 Jan 2001 03:03:11 -0500
Received: from hermes.mixx.net ([212.84.196.2]:12294 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130356AbRADICw>;
	Thu, 4 Jan 2001 03:02:52 -0500
Message-ID: <3A542D86.BADE2D36@innominate.de>
Date: Thu, 04 Jan 2001 09:00:06 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Belits <abelits@phobos.illtel.denver.co.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A5352ED.A263672D@innominate.de> <Pine.LNX.4.20.0101030838350.13243-100000@phobos.illtel.denver.co.us>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Belits wrote:
> 
> On Wed, 3 Jan 2001, Daniel Phillips wrote:
> 
> > I don't doubt that if the 'power switch' method of shutdown becomes
> > popular we will discover some applications that have windows where they
> > can be hurt by sudden shutdown, even will full filesystem data state
> > being preserved.  Such applications are arguably broken because they
> > will behave badly in the event of accidental shutdown anyway, and we
> > should fix them.  Well-designed applications are explicitly 'serially
> > reuseable', in other words, you can interrupt at any point and start
> > again from the beginning with valid and expected results.
> 
>   I strongly disagree. All valid ways to shut down the system involve
> sending SIGTERM to running applications -- only broken ones would
> live long enough after that to be killed by subsequent SIGKILL.
> 
>   A lot of applications always rely on their file i/o being done in some
> manner that has atomic (from the application's point of view) operations
> other than system calls -- heck, even make(1) does that.

Nobody is forcing you to hit the power switch in the middle of a build. 
But now that you mention it, you've provided a good example of a broken
application.  Make with its reliance on timestamps for determining build
status is both painfully slow and unreliable.  What happens if you
adjust your system clock?  That said, Tux2 can preserve the per-write
atomicity quite easily, or better, make could take advantage of the new
journal-oriented transaction api that's being cooked up and specify its
requirement for atomicity in a precise way.

Do you have any other examples of programs that would be hurt by sudden
termination?  Certainly we'd consider a desktop gui broken if it failed
to come up again just because you bailed out with the power switch
instead of logging out nicely.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
