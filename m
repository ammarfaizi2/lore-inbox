Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRLLQEs>; Wed, 12 Dec 2001 11:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLLQEj>; Wed, 12 Dec 2001 11:04:39 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:23569 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280960AbRLLQE0>; Wed, 12 Dec 2001 11:04:26 -0500
Date: Wed, 12 Dec 2001 17:04:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
In-Reply-To: <20011211223711.C17550@redhat.com>
Message-ID: <Pine.LNX.4.33.0112121701120.6584-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Dec 2001, Benjamin LaHaise wrote:

> On Tue, Dec 11, 2001 at 09:35:15PM -0600, Steven Walter wrote:
> > > +	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > +	nr_pages -= ptr >> PAGE_SHIFT;
> >
> > Isn't this the same as
> > 	nr_pages = (len + PAGE_SIZE -1) >> PAGE_SHIFT;
>
> No.

But this is:

	nr_pages = ((ptr & ~PAGE_MASK) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;

and this even slightly better (at least on ia32):

	mask = PAGE_SIZE - 1;
	nr_pages = ((ptr & mask) + len + mask) >> PAGE_SHIFT;

bye, Roman

