Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbRLaMuq>; Mon, 31 Dec 2001 07:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287501AbRLaMug>; Mon, 31 Dec 2001 07:50:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23822 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287502AbRLaMuV>; Mon, 31 Dec 2001 07:50:21 -0500
Subject: Re: [patch] Prefetching file_read_actor()
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 31 Dec 2001 13:00:21 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), linux-kernel@vger.kernel.org (Linux Kernel),
        manfred@colorfullife.com (Manfred Spraul)
In-Reply-To: <3C2FFB2F.D02095A2@zip.com.au> from "Andrew Morton" at Dec 30, 2001 09:44:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L23C-0004v8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +       if (size > 128) {
> > +               int i;
> > +               for(i=0; i<size; i+=64) {
> > +                       prefetch (kaddr+offset);
> > +                       prefetch (kaddr+offset+(L1_CACHE_BYTES*2));
> > +               }
> > +       }
> > +

Thats almost certainly wrong for most processors. It might work on the PIII
but I wouldnt trust the right results on others. Fix copy_to_user to
have a prefetching version if appropriate

