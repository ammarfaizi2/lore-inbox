Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUATDZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUATDZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:25:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35987 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263909AbUATDZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:25:04 -0500
Subject: Re: [2.4] scsi per-host lock was Re: smp dead lock of
	io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jens Axboe <axboe@suse.de>, hch@lst.de,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58L.0401192316060.10707@logos.cnet>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
	 <20040112151230.GB5844@devserv.devel.redhat.com>
	 <20040112194829.A7078@infradead.org>
	 <1073937102.3114.300.camel@compaq.xsintricity.com>
	 <Pine.LNX.4.58L.0401131843390.6737@logos.cnet>
	 <1074345000.13198.25.camel@compaq.xsintricity.com>
	 <Pine.LNX.4.58L.0401192316060.10707@logos.cnet>
Content-Type: text/plain
Message-Id: <1074568862.13198.73.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 19 Jan 2004 22:21:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 21:19, Marcelo Tosatti wrote:
> Doug,
> 
> Where can I find a copy of uptodate iorl and mlqueue patchsets ?

Red Hat's 2.4.21-9.EL kernel?  ;-)

Seriously, I've already set up 3 new bk trees on linux-scsi.bkbits.net. 
They are 2.4-for-marcelo, 2.4-drivers, and 2.4-everything.  Right now
the trees are still just clones of your current tree.  The plan,
however, is to sort through all of the scsi patches we put into our
kernels and put them into the various trees.  Obviously, the everything
tree will have both the iorl and mlqueue patches plus the other stuff. 
The for-marcelo tree is stuff that is agreed to be appropriate for
mainline.  The drivers tree is where I'll start sticking driver updates
that come across linux-scsi for the 2.4 kernel.

> I cant enjoy the feeling of splitting a global lock at this point in 2.4's
> lifetime, but it has been in RedHat's and SuSE's trees for long.
> 
> A reason to have it its the dependacy of mlqueue patch. You said most
> drivers are handling the BUSY/QUEUE_FULL hangs by themselves, you mention
> "IBM zfcp" / Emulex which dont. What other drivers suffer from the same
> problem ?

Well, that's a hard to answer question.  First, the problem only shows
up on drivers that actually enabled tagged queuing and use a reasonably
deep queue depth (normally).  So, that automatically strikes out most of
the older ISA and crap hardware drivers since they only do a command at
a time.  The better drivers; aic7xxx (new and old), ncr53c8xx, sym1 and
sym2, qla2x00, etc.; work around the problem.  It's mainly newer drivers
that vendors are starting to write and who don't know the history of the
broken mid layer handling of QUEUE_FULL and BUSY situations.  So, I
cited the two I know of off the top of my head, and there may be others
but I would actually have to look at the source code to identify them
(when 98% of the scsi market is QLogic and NCR/SYM and aic7xxx, those
other drivers fall through the cracks).  Of course, one of the other
issues is that each driver that tries to handle this situation itself
does it in a different manner, and the correctness of those varying
implementations is also an issue to consider.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


