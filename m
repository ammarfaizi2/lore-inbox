Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVF0PwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVF0PwC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVF0Pnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:43:31 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:28604 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262111AbVF0PKx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:10:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ce7wgL9XpV7LfAKpnwPZwWFHzxCF12hqBPs8nDS0e3d66s2IQznhJLJyurAd11fNHtLWEm/kV/+MPo2vg//TpUCcBUtnFbFFXFG5vwTaUOcCtLwRz1Wq70ZfciA2YO2wggyy8e+XmprCrcOI3iPvUymQTrCPA+FY6aPVCSVqpGA=
Message-ID: <111aefd05062708105e924a26@mail.gmail.com>
Date: Mon, 27 Jun 2005 11:10:52 -0400
From: Chris Penney <cpenney@gmail.com>
Reply-To: penney@msu.edu
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [Jfs-discussion] Re: Question about file system failure
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jfs-discussion@lists.sourceforge.net
In-Reply-To: <1119883552.9296.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <111aefd05062707103d24f568@mail.gmail.com>
	 <1119883314.9271.29.camel@localhost>
	 <1119883552.9296.32.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Mon, 2005-06-27 at 09:41 -0500, Dave Kleikamp wrote:
> > On Mon, 2005-06-27 at 10:10 -0400, Chris Penney wrote:
> > > I had an NFS file server using JFS fail this weekend.  A reboot, which
> > > made fsck do a full check, seems to have cleared everything up.  The
> > > initial errors I got were:
> > >
> > > Jun 25 09:27:04 nicfs2 kernel: Incorrect number of segments after building list
> > > Jun 25 09:27:04 nicfs2 kernel: counted 16, received 15
> > > Jun 25 09:27:04 nicfs2 kernel: req nr_sec 320, cur_nr_sec 8
> >
> > These are coming from scsi_init_io() in drivers/scsi/scsi_lib.c.  I
> > don't know what it means, but I'm inclined to think that it indicates a
> > software bug rather than a hardware error.
> >
> > > Jun 25 09:27:04 nicfs2 kernel: device-mapper: dm-multipath: Failing path 8:96.
> > > Jun 25 09:27:04 nicfs2 kernel: cfq: depth 4 reached, tagging now on
> > > Jun 25 09:27:04 nicfs2 kernel: end_request: I/O error, dev sdc, sector
> > > 1592060824
> > > Jun 25 09:27:04 nicfs2 kernel: device-mapper: dm-multipath: Failing path 8:32.
> > > Jun 25 09:27:04 nicfs2 kernel: end_request: I/O error, dev sdc, sector
> > > 1592062936
> >
> > I'm not sure if dm-multipath may be responsible.
> >
> > > Following that was a flurry of JFS errors.  I assume these messages
> > > have nothing at all to do with JFS, but I wanted to make certain.
> >
> > I don't think that JFS is the cause.
> >
> > > I can't turn up much googling that error.  If anyone has any idea what
> > > caused that I'd love to hear it.
> >
> > I'm copying this to linux-kernel in the hopes that someone there will be
> > able to help.  It would be useful to know what kernel you are running.
> 
> Well, I meant to cc linux-kernel.  :-)
> 

I'm running:
  * SMP Pentium 4 w/ hyperthreading enabled (IBM x345)
  * Dual QLogic 2340 HBAs
  * STK D280 Disk Array (nothing in logs)
  * Kernel 2.6.11.5 (built around March 24th)
  * 2.6.11-rc3-udm2 patch
  * linux-2.6.11-NFS_ALL patch (this was critical for me)

I'm using DM to make four multipath devices (each device is a 1TB lun)
and then one stripe made from the four multipaths.  Because the array
is unsupported by multipathd (at least in the code I have) it can only
failover once.  We then manually fail it back to primary if that
happens (which hasn't happened outside of testing).


> > > One last question, for an NFS server is it better to mount the volume
> > > with errors=panic?  It seems like that would keep I/Os from failing
> > > due to it being a read-only file system on error.  In this case it
> > > would seem like a panic + boot would have let a lot of processes (this
> > > is used in a batch environment) resume.
> >
> > Seems reasonable, but I'll let others comment.
> >
> > >    Chris
> >
> > Thanks,
> > Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
> 
> 

Thanks,

   Chris
