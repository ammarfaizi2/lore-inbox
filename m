Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319123AbSIDKdG>; Wed, 4 Sep 2002 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSIDKdG>; Wed, 4 Sep 2002 06:33:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:8617 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S319121AbSIDKdE>;
	Wed, 4 Sep 2002 06:33:04 -0400
Date: Wed, 4 Sep 2002 12:37:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020904103737.GA9936@win.tue.nl>
References: <dledford@redhat.com> <20020903171321.A12201@redhat.com> <200209032148.g83LmeP09177@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209032148.g83LmeP09177@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 04:48:39PM -0500, James Bottomley wrote:

> If you're hitting error recovery so often that whether it recovers
> in  half a second or several seconds makes a difference, I'd say
> there's something else wrong.

Not that I want to contradict, but an example.
Without my sd.c patch from yesterday or so (fixing MODE SENSE calls)
an "insmod usb-storage.o" would take 14 minutes and 6 seconds for me.

[One USB device, with 3 subdevices, gets into a bad state when
presented with a MODE SENSE command that asks for more than the
56 bytes it has available. For each of the three subdevices we
get a long sequence of retries, abort, reset, host reset, bus reset
before it is taken off-line.]

The scsi error recovery has many bad properties, but one is its slowness.
Once it gets triggered on a machine with SCSI disks it is common to
have a dead system for several minutes. I have not yet met a situation
in which rebooting was not preferable above scsi error recovery,
especially since the attempt to recover often fails.

Andries
