Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbTCMXNP>; Thu, 13 Mar 2003 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbTCMXNP>; Thu, 13 Mar 2003 18:13:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262963AbTCMXNN>;
	Thu, 13 Mar 2003 18:13:13 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Mark Haverkamp <markh@osdl.org>
To: Doug Ledford <dledford@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <3E711194.9010505@redhat.com>
References: <20030228133037.GB7473@jiffies.dk>
	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>
	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>
	 <3E6FC8D6.7090005@torque.net>
	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
	 <1047570132.30105.7.camel@markh1.pdx.osdl.net>
	 <3E711194.9010505@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047597729.30103.386.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 15:22:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 15:17, Doug Ledford wrote:
> Mark Haverkamp wrote:
> 
> > Does the cmd_per_lun element of the Scsi_Host_Template structure serve
> > more than one purpose? 
> 
> Only when inappropriately abused by LLDD authors.  The cmd_per_lun value 
> is suppossed to be for untagged devices only!  If you have a tape drive 
> that doesn't support tagged commands but you want to be able to 
> internally have the next command queued up and ready to go when the 
> current command completes (in order to keep it streaming better), then 
> you can set cmd_per_lun to 2 and you will get two outstanding commands 
> for this device at a time.  I used that so that in my interrupt handler 
> I could send the next command to the device before I passed the 
> completed command up to the SCSI layer.
> 
> > In scsi_alloc_sdev it is passed into
> > scsi_adjust_queue_depth.  In the aacraid case this is 512.  Later the
> > aacraid driver (in aac_slave_configure) sets the queue depth to either
> > 128 for tagged or 1 if not.
> 
> That's where you are suppossed to set the queue depth on tagged devices.

Then it sounds like the aacraid driver could set cmd_per_lun to a small
number like one since the real queue depth will be set later in
aac_slave_configure.

Mark.
-- 
Mark Haverkamp <markh@osdl.org>

