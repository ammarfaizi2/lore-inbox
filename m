Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWJ2WGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWJ2WGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWJ2WGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 17:06:05 -0500
Received: from iona.labri.fr ([147.210.8.143]:4505 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1030380AbWJ2WGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 17:06:02 -0500
Message-ID: <454525C1.3070804@ens-lyon.org>
Date: Sun, 29 Oct 2006 23:05:53 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Ken Moffat <zarniwhoop@ntlworld.com>
CC: Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061029213106.GA25865@deepthought.linux.bogus>
In-Reply-To: <20061029213106.GA25865@deepthought.linux.bogus>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Moffat wrote:
> On Sun, Oct 29, 2006 at 08:20:17PM +0100, Gregor Jasny wrote:
>   
>> Hi,
>>
>> Today I tried the new cdparanoia from Debian Sid (3.10+debian~pre0-2).
>> When I started ripping with "cdparanoia -d /dev/scd0 1" my system
>> freezes after some seconds. There is no oops and even the console
>> cursor stops blinking.
>>
>> If I start cdparanoia with -g /dev/scd0 it starts ripping and but the
>> kernel prints many "program cdparanoia not setting count and/or
>> reply_len properly" warnings. But this seems to be a cdparanoia bug.
>>
>> My CDROM:
>> Vendor:                    PIONEER
>> Product:                   DVD-ROM DVD-106
>> Revision level:            1.22
>>
>>     
>  I'm guessing this is really an IDE drive ?  If so, I suspect the
> problem is in scsi emulation (which doesn't deny that the bug might
> be at least partly in the application, although hanging the box is
> nasty).
>
>  Specifically, I've just compiled that version with the debian patch
> on my (non-debian) amd64 and successfully ripped a CD (without any
> log messages) on both 2.6.18 and 2.6.19-rc3 using /dev/hdc.
>
>  So, if this isn't a real SCSI drive, as a work-around you could try
> disabling ide-scsi and use the IDE device name.
>   

I don't think it is ide-scsi related at all. I would rather think about
libata and/or SATA drivers (I am not sure how to call those IDE drives
that appear as SATA devices...). As shown in the Debian bug report that
Gregor cited[1], the problem has been observed on various machines with
the ata_piix SATA driver (with 2.6.16, .17, .18 and .19-rc kernels).

Brice

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901

