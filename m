Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282764AbRK0DVV>; Mon, 26 Nov 2001 22:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282766AbRK0DVM>; Mon, 26 Nov 2001 22:21:12 -0500
Received: from femail16.sdc1.sfba.home.com ([24.0.95.143]:14503 "EHLO
	femail16.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282764AbRK0DVC>; Mon, 26 Nov 2001 22:21:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 19:19:54 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk> <0111261800340R.02001@localhost.localdomain> <9tuugv$f72$1@cesium.transmeta.com>
In-Reply-To: <9tuugv$f72$1@cesium.transmeta.com>
MIME-Version: 1.0
Message-Id: <0111261919540W.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 21:41, H. Peter Anvin wrote:
> Followup to:  <0111261800340R.02001@localhost.localdomain>
> By author:    Rob Landley <landley@trommello.org>
> In newsgroup: linux.dev.kernel
>
> > On Monday 26 November 2001 20:23, Ian Stirling wrote:
> > > > Now a cache large enough to hold 2 full tracks could also hold dozens
> > > > of individual sectors scattered around the disk, which could take a
> > > > full second to write off and power down.  This is a "doctor, it hurts
> > > > when I do this" question.  DON'T DO THAT.
> > >
> > > Or, to seek to a journal track, and write the cache to it.
> >
> > Except that at most you have one seek to write out all the pending cache
> > data anyway, so what exactly does seeking to a journal track buy you?
>
> It limits the amount you need to seek to exactly one seek.
>
> 	-hpa

But it's already exactly one seek in the scheme I proposed.  Notice how of 
the two tracks you can be write-cacheing data for, one is the track you're 
currently over (no seek required, you're there).  You flush to that track, 
there's one more seek to flush to the second track (which you were only 
cacheing data for to avoid latency, so the seek could start immediately 
without waiting for the OS to provide data), and then park.

Now a journal track that's next to where the head parks could combine the 
"park" sweep with that one seek, and presumably be spring powered and hence 
save capacitor power.  But I'm not 100% certain it would be worth it.  (Are 
normal with-power-on seeks towards the park area powered by the spring, or 
the... I keep wanting to say "stepper motor" but I don't think those are what 
drives use anymore, are they?  Sigh...)

Rob
