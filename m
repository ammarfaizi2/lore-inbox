Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934369AbWKVLES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934369AbWKVLES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934419AbWKVLES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:04:18 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:34764 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S934369AbWKVLER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lB6iJ4sRfjhnGo8ewEERW69gqosL7+eh9PSL+y0RACZ5Q8Y9Q49b+hGXc/U+ee4TVtNGqhqa03KI+x66B/CWh14PdNSdQU0+44mPyQ7AGn0yUsJXO/SgVVdV8gA4DqfAKR/MhfCqZZx0IeJSulqXBc+u/sMR+gKWmpzRA6VN5aQ=
Message-ID: <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
Date: Wed, 22 Nov 2006 12:04:16 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061122105703.GZ8055@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
	 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
	 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
	 <20061122080312.GL8055@kernel.dk>
	 <9a8748490611220255v53bc667y74b05e2b69281f25@mail.gmail.com>
	 <20061122105703.GZ8055@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Wed, Nov 22 2006, Jesper Juhl wrote:
> > On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >On Tue, Nov 21 2006, Linus Torvalds wrote:
> > >> I don't think we use any irq-disable locking in the VM itself, but I
> > >could
> > >> imagine some nasty situation with the block device layer getting into a
> > >> deadlock with interrupts disabled when it runs out of queue entries and
> > >> cannot allocate more memory..
> > >
> > >Not likely. Request allocation is done with GFP_NOIO and backed by a
> > >memory pool, so as long the vm doesn't go totally nuts because
> > >__GFP_WAIT is set, we should be safe there. If it did go crazy, I
> > >suspect a sysrq-t would still work.
> > >
> > >If bouncing is involved for swap, we do have a potential deadlock issue
> > >that isn't fixed yet. I just whipped up this completely untested patch,
> > >it should shed some light on that issue.
> > >
> > Thanks Jens, I'll apply that later tonight and force a few lockups and
> > see if I get any extra details with that patch.
>
> Can you post a full dmesg too, as well as clarify which device holds the
> swap space?
>
Sure. I'll post a full dmesg as soon as I get home.

The swap partition is on a IBM Ultrastar U160 10K RPM SCSI disk,
hooked up to an Adaptec 29160N controller, using the aic7xxx driver.
That disk holds all my filesystems as well and the controller also has
a SCSI DVD drive and a SCSI CD writer attached to it.  No SATA/PATA
devices in the box, in case that matters.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
