Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272407AbTG2VoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272409AbTG2VoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:44:11 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:6156 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S272407AbTG2VoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:44:06 -0400
Date: Tue, 29 Jul 2003 22:44:04 +0100
From: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
To: Kent Borg <kentborg@borg.org>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729214404.GB21517@bodmin.doc.ic.ac.uk>
References: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk> <20030729172035.D6570@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729172035.D6570@borg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-07-29 17:20:35 +0000, Kent Borg wrote:
> On Tue, Jul 29, 2003 at 08:15:06PM +0100, John Bradford wrote:
> > Does anybody have any suggestions for recommended standard uses for
> > parallel port connected LEDs?
> 
> I think someone else mentioned notification of e-mail.  Well, I get
> too much e-mail for that (I am on the kernel list, after all) but that
> suggestion make me think of a soft of "Check Engine" light.
> 
> In my Red Hat box there are various sanity checks that happen
> regularly and they send me an e-mail when one of those items goes
> wrong.  For example, if a raid disk dies or a partition gets too full
> (what are others?), I get an e-mail.  It might be nice to have those
> programs also light an LED.

Try libleds (hastily written just now ;-)) from
http://csgsoft.doc.ic.ac.uk/leds -- it should make the LED component of
those programs dead easy to write, and also protect you against any
changes anyone ever makes to the ioctls.

I guess you could also port libleds to some other system, but why would
you want to use anything other than linux?

There's no real documentation as yet, but the code is complete.  sample
usage:

#include <libleds/libleds.h>
.
.
.
led_t myled;
char ledstatus;

if (reserve_led(&myled) !=0) /* You should similarly check the rc from
the other fns, but I shan't bother here */
{
  perror ("Tried to reserve a LED");
  exit (EXIT_FAILURE);
}
led_status (myled, &status);
/* status is now nonzero if LED is on, zero if off */
status = !status;
led_set (myled, status);
/* Just toggled it */
release_led (myled);
/* SIGSEGV comes to those who use a led_t after release_led */

V1.1 will have a man page.  Woohoo.

Regards,

Philip Willoughby

Systems Programmer, Department of Computing, Imperial College, London, UK
-- 
echo bzidd@nfo.ho.co.se | tr "bizndfohces" "pwgd9ociaku"
Why reinvent the wheel?                 Because we can make it rounder...
