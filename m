Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSGXQxB>; Wed, 24 Jul 2002 12:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSGXQxB>; Wed, 24 Jul 2002 12:53:01 -0400
Received: from dsl-213-023-022-208.arcor-ip.net ([213.23.22.208]:63431 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317419AbSGXQw7>;
	Wed, 24 Jul 2002 12:52:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: DAC960 Bitrot
Date: Wed, 24 Jul 2002 18:57:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17WlGV-00052g-00@starship> <20020724143931.GG5159@suse.de>
In-Reply-To: <20020724143931.GG5159@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17XPSR-0007tD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 July 2002 16:39, Jens Axboe wrote:
> The only changes I did to this driver where trivial conversions in the
> 2.5.1-pre days, in fact even before multi-page bio's existed. This,
> btw, is also something you should keep an eye out for -- multi-page bio
> support is currently broken.

I spotted that.  I changed bio_size (which is gone) to bio_sectors(bio) << 9, 
is this correct?

> I would suggest also moving DAC960 to the
> pci dma api (this is a must) and then move it to use the generic block
> helpers for mapping requests. That way there isn't a lot of nasty
> duplication there as well, plus it will automatically get the multi-page
> issues right.

My first concern is to get something working any way I can so that I can 
start doing regression testing.  True/false: the bad old way of doing dma 
will still work, it's just deprecated?  If true, then I should (trivially) 
switch back to the old way of doing things, get the rest working, then 
convert to the dma api.  Maybe *you* could make all the changes at the same 
time and expect to end up with something that works, but I can't.

The alternative is to go back many kernel versions and find the first one  
that broke something, but I don't want to do that because too much else was 
broken at the time.

> Hmm, is DAC960 using a full major per controller?!

As you saw, it implements the top level block interface instead of being a 
scsi device as it should be.  So for disk subsystems we have: 1) IDE 2) SCSI 
3) DAC960.  Eep.  At some point it's all going to be SCSI, right?

-- 
Daniel
