Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUGTTXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUGTTXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUGTTNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:13:34 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:53336 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266181AbUGTTL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:11:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [0/25] Merge pmdisk and swsusp
Date: Tue, 20 Jul 2004 12:41:51 -0500
User-Agent: KMail/1.6.2
Cc: sam@ravnborg.org, Pavel Machek <pavel@suse.cz>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net> <20040720164640.GH10921@atrey.karlin.mff.cuni.cz> <20040720192858.GB9147@mars.ravnborg.org>
In-Reply-To: <20040720192858.GB9147@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407201241.52334.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 July 2004 02:28 pm, sam@ravnborg.org wrote:
> On Tue, Jul 20, 2004 at 06:46:40PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > In the end, these patches remove pmdisk from the kernel and clean up the
> > > swsusp code base. The result is a single code base with greatly improved
> > > code, that will hopefully help others underestand it better.
> > 
> > Followup patch:
> > 
> > * if machine halt fails, it is very dangerous to continue.
> > 
> > diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
> > --- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
> > +++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
> > @@ -63,6 +63,9 @@
> >  		break;
> >  	}
> >  	machine_halt();
> > +	/* Valid image is on the disk, if we continue we risk serious data corruption
> > +	   after resume. */
> > +	while(1);
> 
> Would be nicer to use:
> 
> 	while(1)
> 		/* Loop forever */;
> 
> 	Sam

And even nicer would be remove swsusp signature from swap and restore state as
original version did so user could do clean shutdown...

-- 
Dmitry
