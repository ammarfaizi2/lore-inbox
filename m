Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRKLUFq>; Mon, 12 Nov 2001 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKLUFg>; Mon, 12 Nov 2001 15:05:36 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:65455 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280980AbRKLUFV>; Mon, 12 Nov 2001 15:05:21 -0500
Importance: Normal
Subject: Re: Re: Hardsector size support in 2.4 and 2.5
To: dalecki@evision.ag
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF9F38B076.0F9781F3-ON85256B02.006D5DFE@raleigh.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Mon, 12 Nov 2001 14:05:19 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/12/2001 03:05:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> > I was wondering if 2.5 will *really* support different hard sector
> > sizes. Today the hardsect array in the kernel seems to serve
> > little purpose. Drivers fill it in, but then what? It does not appear
> > to be used in any io path computations as illustrated by code
> > in submit_bh and generic_make_request which use a few
> > hardcoded shifts by 9 when dealing with sector sizes.
> >
> > Is the hardsect array on the way *in* or the way *out* of the
> > kernel? Will 2.5 take the real hardsector value into account?
> > Or can we expect everything to be handled in 512 byte
> > multiples  (as we do today)?

> It is on it's way out, since:

That is good, then the code should be less confusing.

> 1. Most hardware sec sizes are obscelny lower that the minimal logical
> sizes those days (512 ver. 4096 page size),
> so the tuning there doesn't matter.

> 2. All of it is "tuning", which can be handled generically on higher
> levels. (Like setting FS blocksize....)

> 3. The hard limits are handled on device driver level anyway (best
> example here are the odd fs block sizes for iso9660 filesystem).

So any block device, can always expect to receive buffer heads
whose b_rsector value represents the offset from the beginning
of that device in 512 byte multiples? And this will continue
to hold true in 2.5 as well?

