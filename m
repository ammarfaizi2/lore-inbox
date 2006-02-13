Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWBMTqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWBMTqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWBMTqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:46:49 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:46386 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964816AbWBMTqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:46:49 -0500
Message-ID: <43F0E1EC.4050804@cfl.rr.com>
Date: Mon, 13 Feb 2006 14:45:48 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: iSteve <isteve@rulez.cz>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <2006021 <20060213185112.79da8ecc@silver>
In-Reply-To: <20060213185112.79da8ecc@silver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 19:47:40.0405 (UTC) FILETIME=[592F6250:01C630D6]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--10.290000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm... the format appears to be failing with a seek error.  My guess as 
to the cause of this is either bad media or a bad drive.  Are you sure 
this drive can handle 80 min / 700 MB disks?

I'm not sure this switch does what I think it does because I don't have 
the source code in front of me, but after blanking try:

cdrwtool -m 259808

If that did what I think it does, it should attempt to format the disc, 
but not all of it.  If the drive just doesn't like the outer edges, that 
might work. 

iSteve wrote:
> Tried. Tried also with setting -t 10 (the medium is 10x), without -p 1 (still
> trying fixed packet size, same size). Out of four attempts, all failed.
>  ----[snipet]----
> # cdrwtool -d /dev/cdrw -q -p 1
> using device /dev/cdrw
> fixed packets
> 4690KB internal buffer
> setting write speed to 12x
> Settings for /dev/cdrw:
>         Fixed packets, size 32
>         Mode-2 disc
>
> I'm going to do a quick setup of /dev/cdrw. The disc is going to be blanked and
> formatted with one big track. All data on the device will be lost!! Press
> CTRL-C to cancel now. ENTER to continue.
>
> Initiating quick disc blank
> Disc capacity is 295264 blocks (590528KB/576MB)
> Formatting track
> wait_cmd: Input/output error
> Command failed: 04 17 00 00 00 00 00 00 00 00 00 00 - sense 05.64.00
> format disc: Illegal seek
> ---[/snipet]----
>
> DMESG:
> cdrom: This disc doesn't have any tracks I recognize!
>
> Please note that although I've been testing packet writing on 2.6.15.1, I'm
> performing the initial burning on 2.6.12.1(+ squashfs), I apologize for not
> mentioning this.
>
> The udftools are from Debian, in version 1.0.0b3-11.
>   

