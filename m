Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbTCMPdZ>; Thu, 13 Mar 2003 10:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbTCMPdZ>; Thu, 13 Mar 2003 10:33:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:17830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262411AbTCMPdX>;
	Thu, 13 Mar 2003 10:33:23 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Mark Haverkamp <markh@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dougg@torque.net, Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
References: <20030228133037.GB7473@jiffies.dk>
	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>
	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>
	 <3E6FC8D6.7090005@torque.net>
	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1047570132.30105.7.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 07:42:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 17:06, Alan Cox wrote:
> On Wed, 2003-03-12 at 23:55, Douglas Gilbert wrote:
> >          /*
> >           * Limit max queue depth on a single lun to 256 for now.  Remember,
> >           * we allocate a struct scsi_command for each of these and keep it
> >           * around forever.  Too deep of a depth just wastes memory.
> >           */
> >          if(tags > 256)
> >                  return;
> > ....
> 
> I can see the memory consideration. However the thing can really handle big
> queues well. Possibly we should be setting the queue to 512 / somefunction(volumes)
> though to avoid the worst case overcommit here
> 

Does the cmd_per_lun element of the Scsi_Host_Template structure serve
more than one purpose?  In scsi_alloc_sdev it is passed into
scsi_adjust_queue_depth.  In the aacraid case this is 512.  Later the
aacraid driver (in aac_slave_configure) sets the queue depth to either
128 for tagged or 1 if not.

Mark.
-- 
Mark Haverkamp <markh@osdl.org>

