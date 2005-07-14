Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVGNRyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVGNRyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVGNRyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:54:49 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:11337 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262721AbVGNRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:54:48 -0400
Date: Thu, 14 Jul 2005 10:54:47 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
Message-ID: <20050714175447.GA16651@hexapodia.org>
References: <20050713185955.GB12668@hexapodia.org> <42D67D84.2020306@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D67D84.2020306@suse.de>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:58:12PM +0200, Stefan Seyfried wrote:
> Andy Isaacson wrote:
> > Yesterday I booted my laptop to 2.6.13-rc2-mm1, suspended to swsusp,
> > and
[snip]
> > and got a panic along the lines of "Unable to find swap space, try
>
> a panic? it should only be an error message, but the machine should
> still be alive.

Well, the console was left on the swsusp VT (guess that's not suprising)
and I was hurrying to catch the train, so I didn't investigate, I just
held down the power button for 5 seconds.

> > swapon -a".  Unfortunately I was in a hurry and didn't record the
> > error
> > messages.  I powered off, then a few minutes later powered on again.
>
> Powered off hard or "shutdown -h now"?

Hard.  It's a Thinkpad X40 with ACPI, so I hold down the power button
for a few seconds to power off.

> > At this point, it resumed *to the swsusp state from yesterday*!
[snip severe ext3 damage]
> > It's extremely unfortunate that there is *any* failure mode in
> > swsusp
> > that can result in this behavior.
>
> I of course won't say that this cannot happen, but by design, the
> swsusp
> signature is invalidated even before reading the image, so
> theoretically
> it should not happen.

Yes, I'd seen that happen on earlier swsusps, so I was quite suprised
when it blew up like this.

Perhaps the image should be more rigorously checked?  I'm wishing that
it would verify that the header and the image matched, after it finishes
reading the image.  For example, computing the hash

MD5(header || image)     (|| denotes "concatenate" in crypto pseudocode.)

and storing that hash in a final trailing block.  Additionally, of
course, as soon as the resume has read the image it should overwrite the
header; and the header should include jiffies or something along those
lines to ensure that it won't accidentally have the same contents as the
previous image's header.

The hash doesn't have to be MD5; even a CRC should suffice I think...

-andy
