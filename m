Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUAFMjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAFMjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:39:51 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:48523 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262040AbUAFMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:39:39 -0500
Date: Tue, 6 Jan 2004 12:33:30 +0100
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040106113330.GA5827@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051808.49010.bzolnier@elka.pw.edu.pl> <20040105225117.GA5841@leto.cs.pocnet.net> <200401060059.52833.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401060059.52833.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:59:52AM +0100, Bartlomiej Zolnierkiewicz wrote:

> On Monday 05 of January 2004 23:51, Christophe Saout wrote:
> > Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> > scratchpad and ide_multwrite never puts a NULL bio on it.
> 
> After last sector of the whole transfer is processed ide_multwrite() will set
> it to NULL.

No, it doesn't.

                                                                                       
>			/* end early early we ran out of requests */
>			if (!bio) {
>				mcount = 0;
>			} else {
>				rq->bio = bio;
>				rq->nr_cbio_segments = bio_segments(bio);
>				rq->current_nr_sectors = bio_cur_sectors(bio);
>				rq->hard_cur_sectors = rq->current_nr_sectors;
>			}

rq->bio is only set if bio is not NULL.

>  Next IRQ is only ACK of previous datablock, no transfer happens.

You're right, the bi_idx resetting might be redundant but since bio is
never NULL an additional check is superfluous.

> Move it before the comment.

Ok. I will repost when the issue above is worked out.

