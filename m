Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVERMB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVERMB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVERMB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:01:56 -0400
Received: from alog0273.analogic.com ([208.224.222.49]:46307 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261195AbVERMBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:01:53 -0400
Date: Wed, 18 May 2005 08:01:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
In-Reply-To: <20050518111328.7115.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0505180749390.15608@chaos.analogic.com>
References: <20050518111328.7115.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005 linux@horizon.com wrote:

>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> end_request: I/O error, dev 03:00 (hda), sector 6
>>> unable to read partition table
>> [SNIPPED...]
>>
>> You can "fix" this by writing all sectors. Although the data is lost,
>> the flash-RAM isn't. This can (read will) happen if you pull the
>> flash-RAM out of its socket with the power ON.
>
> Er... no.  Trying to write 8K to /dev/hda, I get the above error
> on sector 15.
>

If you can boot DOS or FREE dos on your system, see if the disk
emulation implimented the format-unit command. You can do it with
debug...

- mov dx, 81	; 81 is D: , 80 is C:
- mov cx, 0	; Start at cylinder 0
- mov ah, 7	; Format unit command
- int 13	; BIOS hard-disk service
- int 3		; Catch after call

If the call returned with CY not set and the command took some time
it is likely that new sectors were written and all is well.

> My *other* problems could be fixed by rewriting the affected sector, but
> this one seems to be a doozy.  I never saw "SectorIdNotFound" before.
>
>>  Notice : All mail here is now cached for review by Dictator Bush.
>
> As long as he has to read it personally, that's fine.  I'll get some
> small pleasure watching his lips move.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
