Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274705AbRJAHlS>; Mon, 1 Oct 2001 03:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274708AbRJAHlJ>; Mon, 1 Oct 2001 03:41:09 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:1442 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S274705AbRJAHlA>; Mon, 1 Oct 2001 03:41:00 -0400
Message-ID: <3BB81DE3.5070205@korseby.net>
Date: Mon, 01 Oct 2001 09:40:19 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 vm causes buffer underruns during cd writing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This nasty thing is repeatable for me.

After beginning writing to cd, mem (cache) is growing rapidly and after about 15 
minutes
linux swaps enormous
and the system gets unusable. After about 1 minute cdrecord gets no data
anymore (it crashes) and the system is like it was before.

These problems did not occure with 2.4.9.

The following messages appear:

Sep 26 18:44:49 adlib kernel: scsi : aborting command due to timeout : pid 0, 
scsi0, channel 0, id 1, lun 0 Synchronize Cache 00 00 00 00 00 00 00 00 00
Sep 26 18:44:49 adlib kernel: hdd: irq timeout: status=0xc0 { Busy }
Sep 26 18:44:49 adlib kernel: hdd: DMA disabled
Sep 26 18:44:49 adlib kernel: hdd: ATAPI reset complete
Sep 26 18:44:49 adlib kernel: hdd: irq timeout: status=0x80 { Busy }
Sep 26 18:44:49 adlib kernel: hdd: ATAPI reset complete
Sep 26 18:44:49 adlib kernel: hdd: irq timeout: status=0xd0 { Busy }

I use ide-scsi and /dev/hdd == /dev/scd1 == /dev/cdwriter.

Maybe this problem is in connection with ide-scsi...

At least, here's the output of cdrecord:

0,1,0: HP CD-Writer+ 9100b      Rev: 1.06
WARNING: Cannot read driver table from file 
"/var/tmp/cdrdao-1.1.5-2-buildroot/usr/share/cdrdao/drivers" - using built-in table.
Using driver: Generic SCSI-3/MMC - Version 1.2 (options 0x0010)

WARNING: Unit not ready, still trying...
WARNING: Unit not ready, still trying...
Starting write at speed 4...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
Executing power calibration...
Power calibration successful.
Writing track 01 (mode AUDIO/AUDIO)...
Writing track 02 (mode AUDIO/AUDIO)...
Writing track 03 (mode AUDIO/AUDIO)...
Writing track 04 (mode AUDIO/AUDIO)...
?: Eingabe-/Ausgabefehler.  : scsi sendcmd: no error
CDB:  2A 00 00 01 A5 D9 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 03 00 00 00 00 0A 00 00 00 00 0C 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.002s timeout 180s
ERROR: Write data failed.
ERROR: Writing failed - buffer under run?
ERROR: Writing failed.
Waiting 5 seconds for ejecting...

Kristian

-- 
·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

