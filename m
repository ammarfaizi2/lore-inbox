Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVF0QBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVF0QBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVF0PT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:19:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23453 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261480AbVF0Opy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:45:54 -0400
Subject: Re: [Jfs-discussion] Re: Question about file system failure
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: penney@msu.edu
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jfs-discussion@lists.sourceforge.net
In-Reply-To: <1119883314.9271.29.camel@localhost>
References: <111aefd05062707103d24f568@mail.gmail.com>
	 <1119883314.9271.29.camel@localhost>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 09:45:51 -0500
Message-Id: <1119883552.9296.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 09:41 -0500, Dave Kleikamp wrote:
> On Mon, 2005-06-27 at 10:10 -0400, Chris Penney wrote:
> > I had an NFS file server using JFS fail this weekend.  A reboot, which
> > made fsck do a full check, seems to have cleared everything up.  The
> > initial errors I got were:
> > 
> > Jun 25 09:27:04 nicfs2 kernel: Incorrect number of segments after building list
> > Jun 25 09:27:04 nicfs2 kernel: counted 16, received 15
> > Jun 25 09:27:04 nicfs2 kernel: req nr_sec 320, cur_nr_sec 8
> 
> These are coming from scsi_init_io() in drivers/scsi/scsi_lib.c.  I
> don't know what it means, but I'm inclined to think that it indicates a
> software bug rather than a hardware error.
> 
> > Jun 25 09:27:04 nicfs2 kernel: device-mapper: dm-multipath: Failing path 8:96.
> > Jun 25 09:27:04 nicfs2 kernel: cfq: depth 4 reached, tagging now on
> > Jun 25 09:27:04 nicfs2 kernel: end_request: I/O error, dev sdc, sector
> > 1592060824
> > Jun 25 09:27:04 nicfs2 kernel: device-mapper: dm-multipath: Failing path 8:32.
> > Jun 25 09:27:04 nicfs2 kernel: end_request: I/O error, dev sdc, sector
> > 1592062936
> 
> I'm not sure if dm-multipath may be responsible.
> 
> > Following that was a flurry of JFS errors.  I assume these messages
> > have nothing at all to do with JFS, but I wanted to make certain.
> 
> I don't think that JFS is the cause.
> 
> > I can't turn up much googling that error.  If anyone has any idea what
> > caused that I'd love to hear it.
> 
> I'm copying this to linux-kernel in the hopes that someone there will be
> able to help.  It would be useful to know what kernel you are running.

Well, I meant to cc linux-kernel.  :-)

> > One last question, for an NFS server is it better to mount the volume
> > with errors=panic?  It seems like that would keep I/Os from failing
> > due to it being a read-only file system on error.  In this case it
> > would seem like a panic + boot would have let a lot of processes (this
> > is used in a batch environment) resume.
> 
> Seems reasonable, but I'll let others comment.
> 
> >    Chris
> 
> Thanks,
> Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

