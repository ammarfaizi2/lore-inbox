Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbSIXSk3>; Tue, 24 Sep 2002 14:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSIXSk2>; Tue, 24 Sep 2002 14:40:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261734AbSIXSk2>;
	Tue, 24 Sep 2002 14:40:28 -0400
Date: Tue, 24 Sep 2002 11:45:43 -0700
From: Dave Olien <dmo@osdl.org>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, phillips@arcor.de,
       davidm@napali.hpl.hp.com, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020924114543.E17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <15759.26918.381273.951266@napali.hpl.hp.com> <E17ta3t-0003bj-00@starship> <20020923.135447.24672280.davem@redhat.com> <20020924095456.A17658@acpi.pdx.osdl.net> <15760.40126.378814.639307@napali.hpl.hp.com> <20020924102843.C17658@acpi.pdx.osdl.net> <15760.44345.987685.413861@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15760.44345.987685.413861@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Sep 24, 2002 at 11:21:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking over the main body of the interrupt handler
for the DAC960 ( the DAC960_V[12]_ProcessCompletedCommand()).

The V1 version of this function is over 800 lines long.
The V2 version is 600 lines long.

First off I have an intense dislike for ANY function that
is this long.  

Secondly, most of the stuff in these functions doesn't
seem appropriate for an interrupt handler.  90% of
the code in these functions is executed rarely, and
isn't performance critical.  Most of
these functions involve health monitoring.  In some cases,
where logical drives appear or disappear, the set of
disks visible through the controller must change.

It seems to me that most of this functionality
should be moved into a kernel daemon associated with the
driver.  The interrupt handler could be shrunk to as few
instructions and "if then else" branches as possible, to
shorten the time the spent in the handler and the time the
controller's lock is held.

This is a bigger change than I'm ready to deal with
right now.  First thing is to get the old code structure
to work with the DMA interfaces.  But I think daemon-izing
this code would clean it up and make it more easily
understood as well.  

Perhaps we could do this as part of a "stage-two"
set of changes.


