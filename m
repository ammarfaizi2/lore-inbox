Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTKGWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTKGW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264477AbTKGV7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:38 -0500
Date: Fri, 7 Nov 2003 22:22:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content is read (only directory structure)
Message-ID: <20031107212251.GC14728@suse.de>
References: <20031105084002.GX1477@suse.de> <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org> <20031107082439.GB504@suse.de> <1068195038.21576.1.camel@ulysse.olympe.o2t> <20031107090924.GB616@suse.de> <1068197144.21576.32.camel@ulysse.olympe.o2t> <1068238928.4088.2.camel@m70.net81-64-235.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1068238928.4088.2.camel@m70.net81-64-235.noos.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Nicolas Mailhot wrote:
> Le ven 07/11/2003 à 10:25, Nicolas Mailhot a écrit :
> > Le ven 07/11/2003 à 10:09, Jens Axboe a écrit :
> 
> > > Try with this debug patch then, does it work now?
> > > 
> > > ===== drivers/scsi/scsi_lib.c 1.77 vs edited =====
> > > --- 1.77/drivers/scsi/scsi_lib.c	Tue Oct 14 09:28:06 2003
> > > +++ edited/drivers/scsi/scsi_lib.c	Fri Nov  7 10:08:52 2003
> > > @@ -1215,6 +1215,7 @@
> > >  
> > >  u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
> > >  {
> > > +#if 0
> > >  	struct device *host_dev;
> > >  
> > >  	if (shost->unchecked_isa_dma)
> > > @@ -1229,6 +1230,9 @@
> > >  	 * hardware have no practical limit.
> > >  	 */
> > >  	return BLK_BOUNCE_ANY;
> > > +#else
> > > +	return BLK_BOUNCE_HIGH;
> > > +#endif
> > >  }
> > >  
> > >  struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
> > 
> > Will try this evening when I have physical access to the system. (It's
> > difficult to plug a USB device via ssh;)
> 
> Well, it does work now (couldn't believe my eyes, tried three times in a
> row just to be sure). Is this supposed to be a definitive fix that will
> be in the next bk snapshots or should I wait for something else ?

No it's not a definitive fix. It was just a test - if it works with the
patch applied, it confirms the theory that usb storage is broken wrt
highmem.

-- 
Jens Axboe

