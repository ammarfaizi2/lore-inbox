Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261770AbTCMBiu>; Wed, 12 Mar 2003 20:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCMBiu>; Wed, 12 Mar 2003 20:38:50 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:32530 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S261770AbTCMBit>; Wed, 12 Mar 2003 20:38:49 -0500
Message-ID: <3E6FDF61.8060708@torque.net>
Date: Thu, 13 Mar 2003 11:31:13 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mark Haverkamp <markh@osdl.org>,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>, dledford@redhat.com
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
References: <20030228133037.GB7473@jiffies.dk>	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>	 <3E6FC8D6.7090005@torque.net> <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2003-03-12 at 23:55, Douglas Gilbert wrote:
> 
>>         /*
>>          * Limit max queue depth on a single lun to 256 for now.  Remember,
>>          * we allocate a struct scsi_command for each of these and keep it
>>          * around forever.  Too deep of a depth just wastes memory.
>>          */
>>         if(tags > 256)
>>                 return;
>>....
> 
> 
> I can see the memory consideration. However the thing can really handle big
> queues well. Possibly we should be setting the queue to 512 / somefunction(volumes)
> though to avoid the worst case overcommit here

The situation is different between 2.4 and 2.5 ...

In 2.4 the per device queue_depth is an unsigned char
and that number of scsi_cmnd instances are pre-allocated
in the scsi_build_commandblocks() function. So the worst
case number of scsi_cmnd instances for all scsi devices
is always available (at the expense of [wasted] ram).

In 2.5 queue_depth is an unsigned short and a slab
allocator called "scsi_cmd_cache" is used as required.
There is some throttle logic (or at least it has been
talked about) to make sure one scsi_cmnd instance per
scsi device will always be available.

I think that comment (probably by Doug Ledford) refers
to the 2.5 series before the slab allocator was
introduced.

Doug Gilbert



