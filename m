Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267033AbUBMPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267034AbUBMPL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:11:28 -0500
Received: from gate.in-addr.de ([212.8.193.158]:26556 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S267033AbUBMPLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:11:23 -0500
Date: Fri, 13 Feb 2004 16:12:14 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040213151213.GR21298@marowsky-bree.de>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040212201340.GB1898@reti>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-12T20:13:40,
   Joe Thornber <thornber@redhat.com> said:

> I think the main concern now is over the testing of paths.  Sending an
> io down an inactive path can be very expensive for some hardware
> configurations.  So I'm considering changing a couple of things:
> 
> - Only ever send io to 1 priority group at a time (even test ios).
>   To test the lower priority groups we'd have to periodically switch to
>   them and use them for a bit for both test io and proper io.

You are missing the obvious answer:

- Periodically checking paths is a user-space issue and doesn't belong
  into the kernel. User-space gets to handle this policy.

> - For some hardware there are better ways of testing the path than
>   sending the test io.  Should the drivers expose a test function ?
>   In the absence of this we'd fallback to the test io method.

Again, with user-space taking care of this, it doesn't really matter.

Though exposing a test function does sound nice, even for user-space.

Moving it into kernel land is something which can always be done later,
if there is a really pressing problem.

> The other thing we need is to try and get the drivers to deferentiate
> between a media error and a path error, so that media errors get
> reported up quickly and don't cause false path failures.  This is
> possibly an area that you could help with ?

I thought the IO stack in 2.6 provided us with such sense keys already,
which you'd then need to handle in the DM personality. Of course,
drivers need to make sure they pass up appropriate sense-keys, but
that's a hardware vendor issue and not something which should delay the
DM personality...

Jens, do you have the pointer on this handy?



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

