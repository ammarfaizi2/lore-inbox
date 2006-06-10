Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWFJQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWFJQfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWFJQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:35:31 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:11452 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932314AbWFJQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:35:30 -0400
Date: Sat, 10 Jun 2006 12:34:46 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
In-reply-to: <20060610154213.GA19077@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       "Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <1149957286.4448.542.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 16:42 +0100, Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 05:11:42PM +0200, Stefan Richter wrote:
> > Serge, could you reduce your patch to the nodemgr part and resubmit?
> 
> I'd prefer ieee1394 would just stop creating these thread entirely.
> Sure, rescaning the bus might take some time, but so do pci or especially
> scsi bus rescans.  A user should expect his thread to block when he
> writes to an attribute caled rescan.

1394 bus rescanning takes a _lot_ longer than a PCI rescan. If we don't
do this in a kthread, then we have to do it as a tasklet, and take a
chance of stalling for a few seconds (not ms), preventing other
tasklet's from running. Suboptimal, IMO.

Also, neither PCI nor SCSI rescans occur quite as often as 1394 rescans.
It's more like USB (which also uses a kthread, or at least used to).

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

