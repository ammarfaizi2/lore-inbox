Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUHRIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUHRIrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHRIrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:47:17 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:41683
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265091AbUHRIrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:47:14 -0400
Message-ID: <41231790.7060806@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 10:47:12 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Messer <andreas.messer@gmx.de>
Cc: linux-kernel@vger.kernel.org, Ballarin.Marc@gmx.de, christer@weinigel.se
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home>
In-Reply-To: <20040817155927.GA19546@proton-satura-home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Messer wrote:
> Hello again,
> 
> as i get informed, that the kmail emailclient has not made
> what i want, i decided to use mutt for next time. I will
> include the patch again to make it readable. I have also
> changed the thing with MODE_SELECT_10 to write mode 
> because Christer Weinig figured out, that this CMD may
> be insecure in connection with harddisks.

Of course, cdrecord won't work this way... Anyway, I tried cdrecord and
growisofs with your patch and got some more blocked commands:

This happens with a cd in a plextor cd writer  PX-W5224:

zassenhaus [10:32] fst 105) cdrecord -dao dev=ATAPI:/dev/hdd test.img
...
Supported modes:
cdrecord: Drive does not support SAO recording.
cdrecord: Illegal write mode for this drive.

Aug 18 10:29:38 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:29:38 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:29:38 zassenhaus kernel: SCSI-CMD Filter: 0xed not allowed with read-mode
Aug 18 10:29:38 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:29:38 zassenhaus kernel: SCSI-CMD Filter: 0x55 not allowed with read-mode

Without a cd in the drive, it gives some more commands:
...
Device seems to be: Generic mmc CD-RW.
cdrecord: Operation not permitted. prevent/allow medium removal: scsi sendcmd: no error
CDB:  1E 00 00 00 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 200s
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes:
cdrecord: Drive does not support SAO recording.
cdrecord: Illegal write mode for this drive.

Aug 18 10:39:26 zassenhaus kernel: SCSI-CMD Filter: 0x1e not allowed with read-mode
Aug 18 10:39:26 zassenhaus kernel: SCSI-CMD Filter: 0x1e not allowed with read-mode
Aug 18 10:39:31 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:39:31 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:39:31 zassenhaus kernel: SCSI-CMD Filter: 0xed not allowed with read-mode
Aug 18 10:39:31 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
Aug 18 10:39:34 zassenhaus kernel: SCSI-CMD Filter: 0x55 not allowed with read-mode


When calling the same command on a NEC ND1300A dvd writer, 0xe9 and 0xed
do not occur, the rest is identical.

"growisofs -Z /dev/hdd=test.img" on the NEC fails with
":-( unable to READ FORMAT CAPACITIES: Operation not permitted"

Aug 18 10:45:37 aiken kernel: SCSI-CMD Filter: 0x23 not allowed with read-mode

I will try to add all of those because we need to allow users to write
CDs at the moment, but I have no clue what is safe and unsafe here :-/

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

