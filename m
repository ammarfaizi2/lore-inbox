Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTFVJuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTFVJuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:50:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23301 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264829AbTFVJuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:50:21 -0400
Date: Sun, 22 Jun 2003 03:04:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel.Thibault@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit big console scrolls
Message-Id: <20030622030448.7aa98dfd.akpm@digeo.com>
In-Reply-To: <Pine.GSO.4.21.0306221146170.869-100000@vervain.sonytel.be>
References: <20030622023626.60d2a24e.akpm@digeo.com>
	<Pine.GSO.4.21.0306221146170.869-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 10:04:25.0928 (UTC) FILETIME=[A965B480:01C338A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, 22 Jun 2003, Andrew Morton wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > > -			if (get_user(lines, (char *)arg+1)) {
> > >  						    ^^^^^
> > >  > +			if (get_user(lines, (s32 *)((char *)arg+4))) {
> > >  							    ^^^^^
> > >  >  				ret = -EFAULT;
> > >  >  			} else {
> > >  >  				scrollfront(lines);
> > > 
> > >  Why was the `arg+1' changed to `arg+4'? Do we really want to skip 12 bytes?
> > 
> > It skips three bytes?
> 
> Oops, you're right. But my first question remains: why skip 3 bytes?

Well we want to use a 32-bit quantity, not an 8-bit one.  So Samuel aligned
that quantity 32 bits beyond the 8-bit ioctl `type' arg.

So I guess you'd do:

	struct foo {
		char type;
		char pad[3];
		s32 distance;
	};


