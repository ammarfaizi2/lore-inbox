Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277920AbRJITMW>; Tue, 9 Oct 2001 15:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277919AbRJITMM>; Tue, 9 Oct 2001 15:12:12 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:13098 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S277918AbRJITL6>; Tue, 9 Oct 2001 15:11:58 -0400
Date: Tue, 9 Oct 2001 21:11:31 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: [Emu10k1-devel] Re: Emu10k1 driver update
In-Reply-To: <Pine.LNX.3.96.1011009135124.9171F-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110092100040.3012-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Jeff Garzik wrote:

Point taken.

>From what I see doing locking with a spinlock is quite tricky.

 codec->read_mixer = ac97_read_mixer;  //can be called holding spinlock
 codec->write_mixer = ac97_write_mixer; //can be called holding spinlock
 codec->recmask_io = ac97_recmask_io;
 codec->mixer_ioctl = ac97_mixer_ioctl; //in general can't be called
holding spinlock

and ac97_mixer_ioctl() itself calls ac97_read/write_mixer().

A semaphore on the mixer device open function would do just fine If I
didn't had an interrupt handler also touching the ac97_codec...

Rui

> On Tue, 9 Oct 2001, Rui Sousa wrote:
> > Actually there is no locking implemented for the ac97 codec mixer.
> > It never seemed worth it, even if there are potential races in the code.
> > To have two applications accessing the mixer at the same time is a _very_
> > rare condition and the worse that can happen is to set a wrong volume
> > value. Anyway, I will give it another look and try to come up with a fix.
>
> I have a patch in the wings which adds locking to mixer accesses, for
> via82cxxx_audio, because the lack of locking was causing problems.  So,
> some people with some apps do indeed notice...
>
> 	Jeff
>
>
>
>
> _______________________________________________
> Emu10k1-devel mailing list
> Emu10k1-devel@opensource.creative.com
> http://opensource.creative.com/mailman/listinfo/emu10k1-devel
>

