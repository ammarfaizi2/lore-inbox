Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbUKCX1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUKCX1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUKCXYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:24:20 -0500
Received: from dev.tequila.jp ([128.121.50.153]:12304 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S261987AbUKCXWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:22:09 -0500
Message-ID: <41896816.2090204@tequila.co.jp>
Date: Thu, 04 Nov 2004 08:21:58 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de> <41889EB5.3060304@tequila.co.jp> <20041103090550.GG10434@suse.de>
In-Reply-To: <20041103090550.GG10434@suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/2004 06:05 PM, Jens Axboe wrote:
> On Wed, Nov 03 2004, Clemens Schwaighofer wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>On 11/03/2004 05:43 PM, Jens Axboe wrote:
>>
>>
>>>It should work, are the permissions on your device file correct?
>>
>>that was the first thing I checked:
>>
>>gullevek@pluto:~$ ls -l /dev/scd3
>>brw-rw----  1 root cdrom 11, 3 2004-04-30 09:28 /dev/scd3
>>
>>then I thought I am not in the right group:
>>
>>gullevek@pluto:~$ groups
>>users disk cdrom audio operator video staff games
>>
>>but I am ...
>>
>>I haven't tried to write a CD, but DVD is definilty not possible,
>>because the device is _not_ listed in k3b if started as user. The
>>internal CD writer is, so probably I can write here, because before,
>>this wasn't even listed ...
> 
> 
> Try with this debug patch so we can see if it rejects command it should
> not.

I added the patch again 2.6.9-ac6:

The strange thing is, this time I see a device, but its crippled:

k3b sees it as 7 0.62 1 /157 3474

But this device can not the DVD writer, because the dvd writer is on
/dev/scd3, this strange device above is on /dev/scd0. But still acording
to the settings, this device can burn dvds (Writes-DVD-R(W)s: yes).

So I tried again to start k3b as root, but this time the dvd writer
didn't show up anymore ... Somehow I get here very confused.

this is my dmesg output when I turn on my DVD writer

drivers/usb/input/hid-input.c: event field not found
ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Error parsing configrom for node 0-01:1023
ieee1394: Error parsing configrom for node 0-02:1023
ieee1394: Error parsing configrom for node 0-03:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00e03600500008f2]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: Node changed: 0-02:1023 -> 0-03:1023
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Logged out of SBP-2 device
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Logged out of SBP-2 device
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-02:1023: Max speed [S400] - Max payload [2048]
scsi3 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: PIONEER   Model: DVD-RW  DVR-105   Rev: 1.20
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 5

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiWgWjBz/yQjBxz8RAqQ0AJ0Yqgej/kA2nzh8/DMjh2npJmef1QCeKfDK
oDLsIvckv12GjABqexAnDMM=
=KcWT
-----END PGP SIGNATURE-----
