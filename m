Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWBZOPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWBZOPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWBZOPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:15:09 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:15187 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbWBZOPH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:15:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmCvwUBq3hz92TRuKvOdKLGY832mCuVi5K+kNNWiKWAu2TOx17qP79U6noSkMKvKPxHLSXrjhKk7QVDDM4MmyKtvSIDFXbl0YXczoQwboAf+DJE/21wB9ejTymGrM+Ym6V1KJE95y+YjbkVSF0NJOY+XVWHJsF6XS2/KsWo3t6c=
Message-ID: <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
Date: Sun, 26 Feb 2006 15:15:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Cc: "Nick Warne" <nick@linicks.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4401B689.5050106@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261308.47513.nick@linicks.net> <4401B689.5050106@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Mark Lord <lkml@rtr.ca> wrote:
> Nick Warne wrote:
> ..
> > Feb 19 14:05:31 quake kernel: hda: irq timeout: status=0xd0 { Busy }
> > Feb 19 14:05:31 quake kernel:
> > Feb 19 14:05:31 quake smartd[405]: Device: /dev/hda, not capable of SMART
> > self-check
> > Feb 19 14:05:31 quake smartd[405]: Sending warning via  mail to
> > root@localhost ...
> > Feb 19 14:05:31 quake kernel: hda: status timeout: status=0xd0 { Busy }
> > Feb 19 14:05:31 quake kernel:
> > Feb 19 14:05:31 quake kernel: hda: DMA disabled
> > Feb 19 14:05:31 quake kernel: hda: drive not ready for command
> > Feb 19 14:05:33 quake kernel: ide0: reset: success
> ..
> > I dunno what happened to the drive that time (this is the only logs of the
> > incident) and I turned DMA back on with hdparm - but my question is why is
> > DMA turned off and then left off after a reset?
>
> When I wrote that code in the mid-1990s, the number one causes of drives
> getting confused (and needing to be reset again), were improper DMA timings,
> cablings, and buggy DMA firmware.
>
> So at the time, since DMA was a newish feature for IDE, we figured that
> turning it off after reset was a Good Thing(tm).
>
> And it was.  A more modern implementation might try being more clever about
> such stuff, and Tejun is working on something like that for libata.
>
> In the meanwhile, you could have a shell script just loop in the background,
> turning DMA back on periodically.  If you care.
>

Or how about an option for the IDE driver to "not do that" that people
could enable if needed/wanted?
Or just change the code to "not do that" since we are no longer in the
mid-1990s?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
