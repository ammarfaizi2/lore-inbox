Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTEMHZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbTEMHZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:25:14 -0400
Received: from [193.98.9.7] ([193.98.9.7]:33475 "EHLO mail.provi.de")
	by vger.kernel.org with ESMTP id S263370AbTEMHZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:25:12 -0400
Subject: Re: 2.4.21-rc:  lost interrupt wgen usinf atapi cdrom-drive
From: Michael Reincke <reincke.m@stn-atlas.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052810966.1602.4.camel@pcew80.atlas.de>
References: <E19FTA7-000Mgw-00.arvidjaar-mail-ru@f15.mail.ru>
	 <1052810966.1602.4.camel@pcew80.atlas.de>
Content-Type: text/plain; charset=ISO-8859-15
Organization: STN ATLAS Elektronik GmbH
Message-Id: <1052811475.1618.7.camel@pcew80.atlas.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 09:37:55 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 09:29, Michael Reincke wrote:
> On Tue, 2003-05-13 at 08:21, Andrey Borzenkov wrote:
> > > i upgraded the linux kernel of my computer from 2.4.21-pre4 to
> > > 2.4.21-rc2 and got the following messages in syslog when using my
> > > atapi-cdrom drive:
> > > May 12 09:42:52 pcew80 kernel: hdc: DMA interrupt recovery
> > > May 12 09:42:52 pcew80 kernel: hdc: lost interrupt
> > > May 12 09:42:52 pcew80 kernel: hdc: status timeout: status=0xd0 { Busy }
> > > May 12 09:42:52 pcew80 kernel: hdc: status timeout: error=0x00
> > > May 12 09:42:52 pcew80 kernel: hdc: DMA disabled
> > > May 12 09:42:52 pcew80 kernel: hdc: drive not ready for command
> > > May 12 09:42:52 pcew80 kernel: hdc: ATAPI reset complete
> > 
> > 
> > It smells like ide_do_request forgets to enable interrupts when
> > request queue is empty.
> > 
> > drivers/ide/ide-io.c:
> > 
> > void ide_do_request (ide_hwgroup_t *hwgroup, int masked_irq)
> >                         hwgroup->busy = 0;
> > 
> > Ironically it does not release ide_intr_lock in this case but we
> > are not on m68k so we do not care :)
> > 
> > Could you please try to add local_irq_enable() before ide_release_lock() above and see if it helps?
> > It has been reported to have fixed fix problems for other people. OTOH
> > I did have sevral hard lockups with this so there may be more subtle
> > problems issues.
> The hangs and timeouts and total blocking of the cdrom drive seems to be
> away, but the lost interrupt messages are still there.
> But have in mind I've only a quick test so far.

Bad news the hangs and timeout are still there!

-- 
Michael Reincke, NUT Team 2 (Software Build Management)

STN ATLAS Elektronik GmbH, Bremen (Germany)
E-mail : reincke.m@stn-atlas.de |  mail: Sebaldsbrücker Heerstr 235    
phone  : +49-421-457-2302       |        28305 Bremen                  
fax    : +49-421-457-3913       |




