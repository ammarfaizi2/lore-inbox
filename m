Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbQJ3PYM>; Mon, 30 Oct 2000 10:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbQJ3PYC>; Mon, 30 Oct 2000 10:24:02 -0500
Received: from styx.suse.cz ([195.70.145.226]:11771 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129073AbQJ3PXx>;
	Mon, 30 Oct 2000 10:23:53 -0500
Date: Mon, 30 Oct 2000 16:23:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug
Message-ID: <20001030162345.A5469@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0010261555250.15391-200000@pc24.sr.bham.ac.uk> <Pine.LNX.4.21.0010301130060.28728-200000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010301130060.28728-200000@pc24.sr.bham.ac.uk>; from mpc@star.sr.bham.ac.uk on Mon, Oct 30, 2000 at 11:36:10AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:36:10AM +0000, Mark Cooke wrote:

> As a followup - I modified your reset patch to work with 2.2.x, and in
> doing so, I noticed that it is only the slow get time of day (not
> using TSC) that is affected.  I have my kernel compiled with TSC, so 
> my apparent clock jumping (screen saver starting at odd times) is
> probably not actually due to the timer messing up. (Though I did
> manage initially to convince myself that it had made a difference.
> Good ol' placebo effect in action).
> 
> I guess that the other places where the timer's used could be causing
> some trouble though.  As I have TSC enabled, any reset of the timer's
> not going to get corrected by the patch.
> 
> I'll throw together a program to check for gettimeofday jumping when
> I next have a few minutes to chase this further.

I don't think so. If you check the code paths more closely, you'll see
that the timer is used even in the fast TSC case, the error causes by
too big 'count' variable propagates up to the TSC routine. That's where
I started hunting for the bug.

So no, it wasn't a placebo effect. Put a printk() in the fix statement
to see if it's triggered.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
