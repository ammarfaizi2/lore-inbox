Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSA0WLq>; Sun, 27 Jan 2002 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSA0WL0>; Sun, 27 Jan 2002 17:11:26 -0500
Received: from nrg.org ([216.101.165.106]:55824 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S288833AbSA0WLX>;
	Sun, 27 Jan 2002 17:11:23 -0500
Date: Sun, 27 Jan 2002 14:10:57 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rob Landley <landley@trommello.org>, Pavel Machek <pavel@suse.cz>,
        Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre]
 VM and swap - it's really unusable)
In-Reply-To: <E16Uw3D-0002bm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201271357050.8324-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002, Alan Cox wrote:
> I dont believe anyone has tested the driver hard with pre-empt. Its not that
> this driver can't be fixed. Its that this is one tiny example of maybe
> thousands of other similar flaws lurking. There is no obvious automated way
> to find them either.

You could make the same argument against SMP, but Linux has SMP support
despite all the thousands of SMP flaws that once lurked with no obvious
automated way to find them.  Most of them have been found.

Actually, there is a way to help to automate the finding of preemption
problems:  you keep a log of kernel preemption events in a circular
buffer, and dump the log after something unexpected happens (like a
kernel oops).  Then you search the log for preemptions that happened in
suspicious places.  Kernel preemptions don't happen very often, so the
log usually goes back several seconds, which is usually plenty of time
to catch the preemption that happened in the wrong place.  (Since SMP
locking problems are also preemption problems, this technique can also
catch SMP problems.)

I have a patch to do this for earlier versions of the kernel preemption
patch - I need to bring it up to date and send it to Robert for use with
the latest versions of his patch.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

