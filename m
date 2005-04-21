Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVDUNlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDUNlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVDUNlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:41:40 -0400
Received: from sun3.sammy.net ([68.162.198.6]:62221 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S261375AbVDUNla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:41:30 -0400
Date: Thu, 21 Apr 2005 09:41:25 -0400 (EDT)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Christoph Hellwig <hch@infradead.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] kill old EH constants
In-Reply-To: <20050421100933.GA19586@infradead.org>
Message-ID: <Pine.LNX.4.40.0504210938260.972-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Apr 2005, Christoph Hellwig wrote:

> On Thu, Apr 21, 2005 at 11:58:12AM +0200, Geert Uytterhoeven wrote:
> > sun3_NCR5380.c still uses the following:
> >
> >   - SCSI_ABORT_SUCCESS
> >   - SCSI_ABORT_ERROR
> >   - SCSI_ABORT_SNOOZE
> >   - SCSI_ABORT_BUSY
> >   - SCSI_ABORT_NOT_RUNNING
> >   - SCSI_RESET_SUCCESS
> >   - SCSI_RESET_BUS_RESET
> >
> > causing the driver to fail to build in 2.6.12-rc3. What should I replace them
> > by?
>
> You must replace NCR5380_abort and NCR5380_bus_reset with real new-style
> EH routines.  I'd suggest copying them from NCR5380.c or even better
> scrapping sun3_NCR5380.c in favour of that one completely.

Trust me, there's reasons we don't use NCR5380.c.... (primarily, this has
to due with the order of operations necessary to keep the DMA controller
happpy, which required changing the flow of several functions
(admittedly, I haven't looked into this again since the "new-style"
driver change)).

That being said, it seems the first option needs done.  I suppose I'll
add fixing those two routines to my long list of backlogged sun3 stuff
which needs doing.

-- Sam


