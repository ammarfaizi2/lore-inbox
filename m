Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271898AbRHVACx>; Tue, 21 Aug 2001 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269100AbRHVACn>; Tue, 21 Aug 2001 20:02:43 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:37328 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S271898AbRHVACb>; Tue, 21 Aug 2001 20:02:31 -0400
Subject: Open Tray detection of ide-cdroms broken
Date: 22 Aug 2001 01:54:52 +0200
Organization: Chemnitz University of Technology
Message-ID: <87y9od6kab.fsf@kosh.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since early 2.4 kernels a

| $ mount /mnt/cdrom

on my opened ide-cdroms reports that there is no cdrom in the drive. Old
2.2 kernels closed the tray first and succeeded then.

Aeons ago this issue was discussed already[1], but the current
ide_cdrom_drive_status() function in ide-cd.c contains still the

| if (sense.sense_key == NOT_READY) {
|          if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
|                  return CDS_NO_DISC;
|          else
|                  return CDS_TRAY_OPEN;
|  }

code returning CDS_NO_DISC on "normal" ide drives. Please see [1] for
details.



Enrico

Footnotes: 
[1]  http://boudicca.tux.org/hypermail/linux-kernel/2001week08/0076.html

