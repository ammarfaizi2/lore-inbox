Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312198AbSCREVQ>; Sun, 17 Mar 2002 23:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312200AbSCREVG>; Sun, 17 Mar 2002 23:21:06 -0500
Received: from gear.torque.net ([204.138.244.1]:14863 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S312198AbSCREUv>;
	Sun, 17 Mar 2002 23:20:51 -0500
Message-ID: <3C956B65.3648CF37@torque.net>
Date: Sun, 17 Mar 2002 23:21:57 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.7-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux 2.5.6-dj1
In-Reply-To: <3C94E400.99DCBC12@torque.net> <20020317214256.C5010@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Sun, Mar 17, 2002 at 01:44:16PM -0500, Douglas Gilbert wrote:
> 
>  > Compiled here but didn't link (SMP) :-(
>  >  page_cache_release undefined multiple times in mm/mm.o
> 
>  Probably a side-effect of me removing the radix tree patch.
>  I'll look into this.

Dave,
Sorry, false alarm; "make mrproper" fixed that problem.

So here are some results from testing on my SMP box
(dual Celeron abit); all these worked:

  - advansys driver (*)  holds my root fs
  - aha1542 driver (*)  lightly tested
  - imm (*) 100 MB parallel port zip drive
  - scsi reset [part of James's reservation+reset patch]
  - usb-storage to an ATA maxtor 6L040J2 disk via a lava
    external enclosure
  - usb-storage to a sandisk (8MB compact flash card)
  - usb-storage to a casio digital camera
  - scsi_debug driver

Notes:
  - those drivers marked with (*) are broken on SMP 
    machines in 2.5.7-pre2
  - unfortunately my ieee1394 card is another box,
    the sbp2 driver works in 2.5.7-pre2 (although
    it does have some quirks: my lava box claims
    that an ATA disk is SCSI 6 compliant!)
  - as can be seen, several other subsystems depend on
    the scsi subsystem. My guess is the scsi subsystem
    will be seeing more ATA disks (and cd/dvd writers) 
    in external enclosures via usb-2 and 1394 in the 
    future
  - obviously the scsi mid level patches (I'm thinking of
    the report_lun+twin_inquiry) are not causing any
    problems.
  - I noticed the sym53c8xx-2 driver has been updated.
    There is a dc-390u3w on another machine here. If
    there is any problem, I'll contact you

So all in all the scsi subsystem looks pretty good in
"dj1". I did lose some time when my keyboard + mouse
disappeared (.config problems). For those still having
trouble finding their mouse read Documentation/input/input.txt

>  > There are over 30 scsi subsystem patches backed up in
>  > your tree. Some are over 2 months old. Could
>  > some (or perhaps all) of them get promoted to the
>  > main tree?
> 
>  Indeed. Once Linus returns from vacation, I'll be doing a
>  patch-bombing on a larger scale than usual 8-)
> 
>  Any bits I'm uncertain of, I'll bounce your way first for
>  clarification, deal ?

Fine.

Doug Gilbert
