Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbULMTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbULMTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbULMTko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:40:44 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:23194 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262284AbULMS5H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:57:07 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-20.tower-45.messagelabs.com!1102964223!8373853!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Unknown Issue.
Date: Mon, 13 Dec 2004 13:57:00 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC417F@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unknown Issue.
Thread-Index: AcThPF6BsUj1/TE/TTayE/VL+ERoegABKkng
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Eric Sandeen" <sandeen@sgi.com>
Cc: "Patrick" <nawtyness@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, so XVM has found something wrong at this point.  Any chance the
box 
> had a power failure?  Write caches on ide drives can wreak havoc with 
> journaling filesystems...  i.e. what happened between "the filesystem 
> was working" and "i remounted the filesystem and got this"

For main system: To make a long story short, I was attempting to hook up
a cd burner and dvd reader to SATA via SATA<->PATA adapters and enable
SATA in the kernel for the Intel ICH5 chipset and I was trying different
drivers/options in an attempt to get them to work.  However, please note
during the entire time, the disk that suffered FS corruption was always
hooked to a Ultra ATA/133 Promise Controller.  I believe I had a kernel
panic once and at another time during either loading SATA drivers or IDE
drivers I had a lockup somewhere along the lines and I rebooted
improperly.

For Dell GX1 system: No, all I did was upgrade the kernel [2.6.9 ->
2.6.10-rc2] and reboot, no power outages or crashes at all.  After about
an hour or so, I began to experience these problems.


-----Original Message-----
From: Eric Sandeen [mailto:sandeen@sgi.com] 
Sent: Monday, December 13, 2004 12:50 PM
To: Piszcz, Justin Michael
Cc: Patrick; linux-kernel@vger.kernel.org; linux-xfs@oss.sgi.com; Andrew
Morton; Kristofer T. Karas; Jeff Garzik; Linus Torvalds
Subject: Re: Unknown Issue.

Piszcz, Justin Michael wrote:

> Ah, good question, yes I used xfs_repair, at this point I knew I had
to
> restore from backup and answered "y" to all questions.  I am not sure
> but I do not recall the log being dirty.

Hm, xfs_repair does not ask any questions.

> In the logs on my main machine, it showed the following when it
> attempted to mount the two filesystems (root and boot, /dev/hde4 and
> /dev/hde1 respectively).

> Dec  5 08:23:53 jpiszcz kernel: XFS internal error
> XFS_WANT_CORRUPTED_GOTO at line 1583 of file fs/xfs/xfs_alloc.c.
Caller
> 0xc021de57
(having trouble replaying the log here)

Ok, so XVM has found something wrong at this point.  Any chance the box 
had a power failure?  Write caches on ide drives can wreak havoc with 
journaling filesystems...  i.e. what happened between "the filesystem 
was working" and "i remounted the filesystem and got this"

>
> As far as bad disk/memory, I have tested both systems with memtest86
and
> the result was 0 errors, as far as the disks go, I have not
experienced
> any problems with either of them until I moved to
2.6.9/2.6.10-rc{1,2}.

ok

-Eric
