Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFMUaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFMUaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFMU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:27:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261322AbVFMUYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:24:50 -0400
Date: Mon, 13 Jun 2005 22:25:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Ondrej Zary <linux@rainbow-software.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
Message-ID: <20050613202555.GB27774@suse.de>
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com> <42AD6362.1000109@rainbow-software.org> <1118669975.13260.23.camel@localhost.localdomain> <42AD92F2.7080108@yahoo.com.au> <1118675343.13773.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118675343.13773.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13 2005, Alan Cox wrote:
> On Llu, 2005-06-13 at 15:06, Nick Piggin wrote:
> > > Make sure you have pre-empt disabled and the antcipatory I/O scheduler
> > > disabled. 
> > > 
> > I don't think that those could explain it.
> 
> Try it and see. The anticipatory I/O scheduler does horrible things to
> my IDE streaming performance numbers and to swap performance. It tries
> to merge I/O by delaying it which is deeply ungood when it comes to IDE
> streaming even if its good for general I/O.

Well, AS should only intentionally delay when it has competing threads
fighting for the disk. For a single threaded io case like hdparm, it
should never idle the drive. It never delays to increase merge rate, or
anything like that - only to increase spatial locality on the drive for
two or more processes accessing it simultanously.

-- 
Jens Axboe

