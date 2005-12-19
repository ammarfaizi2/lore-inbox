Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVLSOH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVLSOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVLSOH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:07:28 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:6349 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750751AbVLSOH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:07:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <wwv1x0941ur.fsf@rjk.greenend.org.uk>
Date: Mon, 19 Dec 2005 14:07:24 +0000
From: Richard Kettlewell <rjk@greenend.org.uk>
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
X-Mailer: Norman
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.4 ide-tape not noticing filemarks
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Seagate/Certance ATAPI tape drive, reported thus:

ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
ide-tape: hdd <-> ht0: 1000KBps, 6*54kB buffer, 9720kB pipeline, 110ms tDSC, DMA

I've been using this with ide-scsi in Linux 2.4.31 for my backups.  It
worked OK.

I upgraded to 2.6.14.4 and it seem to have lost the ability to detect
filemarks.  This happens whether I use it via ide-scsi or use the
ide-tape interface directly.

  sfere# mt -f /dev/nht0 rewind
  sfere# dd if=foo of=/dev/nht0 bs=512 count=1
  1+0 records in
  1+0 records out
  512 bytes transferred in 28.162633 seconds (18 bytes/sec)
  sfere# dd if=foo of=/dev/nht0 bs=512 count=1
  1+0 records in
  1+0 records out
  512 bytes transferred in 5.520161 seconds (93 bytes/sec)
  sfere# mt -f /dev/nht0 rewind
  sfere# dd if=/dev/nht0 of=bar bs=512 count=2
  2+0 records in
  2+0 records out
  1024 bytes transferred in 6.392595 seconds (160 bytes/sec)
  sfere# mt -f /dev/nht0 status
  drive type = Generic SCSI-2 tape
  drive status = 512
  sense key error = 0
  residue count = 0
  file number = 0
  block number = 4
  Tape block size 512 bytes. Density code 0x0 (default).
  Soft error count since last status=0
  General status bits on (0):

Am I doing something wrong somewhere, or has ide-tape stopped noticing
filemarks reliably/at all?

(I see the same problem on tapes written under 2.4.31 but read under
2.6.14.4, which is why I think it's a problem with reading and not
writing.)

ttfn/rjk
