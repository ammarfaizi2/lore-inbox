Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTAEEn5>; Sat, 4 Jan 2003 23:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTAEEn4>; Sat, 4 Jan 2003 23:43:56 -0500
Received: from d40.sstar.com ([209.205.179.40]:5628 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id <S262807AbTAEEn4>;
	Sat, 4 Jan 2003 23:43:56 -0500
Message-ID: <3E17BA12.7000904@asjohnson.com>
Date: Sat, 04 Jan 2003 22:52:34 -0600
From: "Andrew S. Johnson" <andy@asjohnson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-SCSI grabs too many drives
References: <fa.ft06krv.t2sv1p@ifi.uio.no> <fa.g96qm0v.1q1m9id@ifi.uio.no>
In-Reply-To: <fa.g96qm0v.1q1m9id@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J.A. Magallon wrote:
> On 2003.01.04 Andrew S. Johnson wrote:
> 
>>I have append="hdc=ide-scsi" in my lilo.conf file,
>>but when I modprobe ide-scsi, it grabs both the
>>CD-RW and the DVD-ROM:
>>
> 
> 
> I think the correct param is "hdc=scsi", with incorrect param and no
> ide-cd loaded, probably ide-scsi grabs anything it can...
> 

Actually, I guessed on my own, and this solves it:

append="hdc=ide-scsi hdd=ide-cd" in lilo.conf

In rc.modules:

/sbin/modprobe ide-scsi
/sbin/modprobe ide-cd

Gives this in dmesg:

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: HP        Model: CD-Writer+ 9100   Rev: 1.0c
   Type:   CD-ROM                             ANSI SCSI revision: 02
hdd: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)

I don't actually know if the hdd=ide-cd does anything for the ide-cd
module, other than keep the ide-scsi module from grabbing it.  Does
anyone know?

Thanks,

Andy Johnson

