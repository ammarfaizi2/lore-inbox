Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUHJS3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUHJS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUHJSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:25:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267545AbUHJSYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:24:51 -0400
Date: Tue, 10 Aug 2004 14:23:53 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Message-ID: <20040810182353.GA17364@devserv.devel.redhat.com>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408101916.17489.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101916.17489.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 07:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 10 August 2004 18:19, Alan Cox wrote:
> > Apply this patch at your peril. Its a work in progress but my IDE exposure
> > meter is beeping and the sick bucket needs emptying 8)
> 
> Could you please split it off on separate patches?

Its almost entirely interdependant (8212 aside). I will split it up a bit
more once its ready for submission but that may take a while. In part I
don't know what the final patch sets will need to be, because I'm still
mapping some of the locking or lack thereof.

> > -	Remove unsafe and essentially unfixable proc code for flipping
> > 	between ide-cd and ide-scsi. Its no longer relevant with SG_IO.
> 
> Shouldn't we deprecate it first...?

It doesn't work now so it clearly isnt being used 8). We hold the lock
because its a proc function and we then replace the proc functions in the
attach method -> deadlock. It is also incredibly hard to fix without a
major rewrite.

> > -	Added pci IDE helpers to do hot unplug
> 
> Locking for ide_hwifs[] should be added first...

I'm not sure its needed because the cfg sem covers it. I'm still trying
to prove that at the moment and it may as you say need a new lock. The
pci IDE helpers for hot unplug just use the same services as the pcmcia
one so aren't that hard. Neither work at the moment but pcmcia ide_cs hasn't
worked for me in 2.6 yet. I still don't know why and clearly I need to 
before I can submit stuff ..

I've not tackled the drive level hotswap forward port yet either, that is
a lot less pressing than hangs on module loads and the pcmcia problem.

Alan

