Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRIGUbv>; Fri, 7 Sep 2001 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272837AbRIGUbl>; Fri, 7 Sep 2001 16:31:41 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:44210 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S272838AbRIGUbZ>; Fri, 7 Sep 2001 16:31:25 -0400
Message-ID: <3B992EC4.ED1F82CB@web.de>
Date: Fri, 07 Sep 2001 22:32:04 +0200
From: Olaf Zaplinski <olaf.zaplinski@web.de>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski wrote:
> 
> Joseph Mathewson wrote:
> >
> > I've just woken up this morning to find my internet gateway machine only
> > responding to pings, and on giving it a keyboard & monitor, a load of
> >
> > scsi0:0:1:0: Attempting to queue an ABORT message
> > scsi0:0:1:0: Cmd aborted from QINFIFO
> > aic7xxx_abort returns 8194
> >
> > errors.
> [...]
> 
> /me too. I had this while booting 2.4.9 with a fresh installed SCSI card
> (AHA2940) + harddisk. What worked for me was to compile the kernel with the
> old Adaptec driver, so it's a driver issue.

Okay, I had it again today:

Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Command not found
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Command not found
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep  7 19:15:19 binky kernel: scsi0:0:0:0: Command not found

Kernel was 2.4.9ac9 with (new) AIC driver 6.2.1, compiled with "Maximum
Number of TCQ Commands per Device" set to 64. I was lucky since it's a RAID1
system (mirror disk is hda). Distro is SuSE 7.2 Professional, machine
K6-2/300 with 128 MB EDO RAM, FS is reiser 3.6.25. Average load is low, it's
a small smtp/imap/www system.

So I compiled the same kernel with the old AIC driver, and it works fine.

I should mention that it is a rather old PCI AHA-2940 Fast SCSI card with an
also older harddisk IBM 0662S12 (that's the whole SCSI chain).
My other machine (AIC-something U2W with Tandberg SLR (U2W) and SCSI CDR
(SE) attached, no HDDs) works fine with the new driver. I just guess when
saying that it seems to me that the driver developers were focused on
up-to-date cards but not the older ones.

Olaf
