Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVL2TGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVL2TGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVL2TGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:06:17 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:31104 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750869AbVL2TGQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:06:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WBq/RQH/L125kUhZ0qu9O5WQacdYZNL4TsUkqxEmPiRknjft7DySK308mnI2l1gDeLpyJ1G23RWYxfdyPqRmcc+C1yA5wQH12hVg0f9sXAlL+7NMo+vprksT8LQ84Ml0q5HibjS+nsQvapMAoeDbGQKAxpNerMTI7x4B3oPOetg=
Message-ID: <5b5833aa0512291106m5142acd5pfb12c4831b60e96b@mail.gmail.com>
Date: Thu, 29 Dec 2005 15:06:15 -0400
From: Anderson Lizardo <anderson.lizardo@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>,
       Anderson Lizardo <anderson.lizardo@gmail.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
In-Reply-To: <20051215134436.GB6211@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213213208.303580000@localhost.localdomain>
	 <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx>
	 <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
	 <43A11204.2070403@drzeus.cx>
	 <20051215091220.GA29620@flint.arm.linux.org.uk>
	 <43A136F1.3040700@drzeus.cx>
	 <20051215100657.GC32490@flint.arm.linux.org.uk>
	 <20051215134436.GB6211@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Reading through the specs I have here, block sizes seem to be all over
> the place.  The MMC card specs seem to imply that any block size can
> be set, from 0 bytes to 2^32-1 bytes.
>
> The PXA MMC interface specification allows the block size to be anything
> from 1 to 1023 bytes, excluding CRC.  It is unclear whether a value of 0
> means 1024.
>
> The MMCI specification allows the block size to be specified as a power
> of two, from 1 to 2048 bytes, excluding CRC.

By "allows" do you mean we can set the block size to arbitrary values
on MMCI too?

The MMC specification v4.1 is clear in one thing: the SET_BLOCKLEN
command should be issued prior to the actual LOCK_UNLOCK command with
*exactly* the password length + 2 bytes (which contains the operation
mode bits and the password length in bytes). The MMC password
unlocking (and other password operations, FWIW) doesn't work on the
OMAP host if the SET_BLOCKLEN command argument and the block size of
the data transfer itself do not match.

--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
