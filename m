Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUAESQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUAESQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:16:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2195 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265285AbUAESQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:16:33 -0500
Date: Mon, 5 Jan 2004 19:16:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christophe Saout <christophe@saout.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040105181627.GB3483@suse.de>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051747.45039.bzolnier@elka.pw.edu.pl> <20040105164902.GA3483@suse.de> <200401051813.30625.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401051813.30625.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05 2004, Bartlomiej Zolnierkiewicz wrote:
> On Monday 05 of January 2004 17:49, Jens Axboe wrote:
> > On Mon, Jan 05 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > calling end_request with a null sector count, ide_end_request will then
> > > > take hard_nr_sectors which will end the whole request even if only one
> > > > bio was finished, huh? Am I missing something here?
> > >
> > > No, it is used mainly to fail requests.
> > >
> > > This hack should be later removed with care
> > > (there is some strange comment about locking).
> >
> > IIRC, it's due to it not always being safe to inspect rq state outside
> > of ide_lock. So that makes 0 a magic value that just means 'end the
> > first chunk' for ide_end_request().
> 
> Why/when it is not safe to do?

You would need to read hwgroup->rq.

-- 
Jens Axboe

