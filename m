Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbSI3FEu>; Mon, 30 Sep 2002 01:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbSI3FEu>; Mon, 30 Sep 2002 01:04:50 -0400
Received: from 12-231-53-84.client.attbi.com ([12.231.53.84]:42729 "EHLO
	12-231-53-84.client.attbi.com") by vger.kernel.org with ESMTP
	id <S261924AbSI3FEt>; Mon, 30 Sep 2002 01:04:49 -0400
Date: Sun, 29 Sep 2002 22:10:08 -0700 (PDT)
From: Paul Cassella <pwc@bigw.org>
X-X-Sender: fortytwo@manetheren
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7-ac3 IDE taskfile io woes
Message-ID: <Pine.LNX.4.44.0209291934050.3146-100000@manetheren>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I turned on taskfile io on my last kernel, and had some stability
problems.  This is ia32, all ide but with ide-scsi.

I experienced severe performance disruptions followed by what appeared to
be a system hang twice.  Before that, I was recieving an "hdd: lost
interrupt"  message every few hours, and the system felt sluggish.  (The
ide-scsi device is hdc, not hdd.)  I have not had these problems with a
kernel compiled without taskfile io.

Is this a known problem?  I can provide more information if it would be
helpful.


I also got the following, which looks like what Nick Evgeniev reported May
24 (2.4.19-pre8 ide bugs).  Andre said to him

> Obviously you have not enable taskfile IO, if you have then you have my
> attention.

As I had enabled taskfile IO, I figured I'd mention this:


11:42:29 bug: kernel timer added twice at c01b0107.

c01b00b8 T ide_set_handler
c01b0110 t atapi_reset_pollfunc

11:45:35 scsi0 channel 0 : resetting for second half of retries.
11:45:35 SCSI bus is being reset for host 0 channel 0.
11:45:35 hdd: ide_set_handler: handler not null; old=c01b0110, new=c01b1474

c01b0110 t atapi_reset_pollfunc
c01b1474 T task_in_intr

11:45:35 bug: kernel timer added twice at c01b0107.

11:47:19 kernel: scsi0 channel 0 : resetting for second half of retries.
11:47:19 kernel: SCSI bus is being reset for host 0 channel 0.
11:47:19 kernel: hdd: ide_set_handler: handler not null; old=c01b0110, new=c01b177c

c01b0110 t atapi_reset_pollfunc
c01b177c T task_out_intr


-- 
Paul Cassella

