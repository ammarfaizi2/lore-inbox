Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWJWONk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWJWONk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWJWONk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:13:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38157 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751385AbWJWONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:13:39 -0400
Date: Mon, 23 Oct 2006 10:13:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Christopher Monty Montgomery <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <453C877E.6090002@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L0.0610231008130.6401-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Helge Hafting wrote:

> >> During boot I get lots of those "Hardware error, end-of-data detected"
> >> messages, but I've never seen it crash during bootup.
> >>     
> >
> > Those messages are from the card reader.  It doesn't seem to be working 
> > right.  It returns the "end-of-data" error in response to a PREVENT MEDIUM 
> > REMOVAL command
> Unlike a cdrom, it doesn't have the means to prevent media removal. :-)

There's nothing wrong with that; lots of devices don't have the means to 
prevent media removal.  The proper response is "Invalid Command", not "End 
of Data".  If the device sent the proper reply you wouldn't get all those 
"Hardware error, end-of-data detected" messages in the log.

> >  and it returns a phase error in response to a READ 
> > command.  In spite of the fact that it claims to have a 256 MB card 
> > present.
> >   
> It has slots for several different cards, all the other
> slots are empty. 

Were all the slots empty?  If yes, the reader should not have indicated a
card was present in that slot.  If no, the reader should have returned the
data from the card instead of a phase error.  Either way, it misbehaved.

> Perhaps it is broken, but interesting as a "stress-test".
> Linux should not crash because of a bad usb thing, just complain.

Linux did not crash because of the bad reader; it crashed because of an 
unrelated bug in ehci-hcd.  (Although it's possible that the bug was 
triggered by the error-recovery for the bad reader.)

Alan Stern

