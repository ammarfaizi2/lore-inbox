Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVALHZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVALHZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVALHZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:25:14 -0500
Received: from pop-5.dnv.wideopenwest.com ([64.233.207.23]:27883 "EHLO
	pop-5.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S261224AbVALHZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:25:03 -0500
Date: Wed, 12 Jan 2005 02:25:01 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs (possible pktcdvd problem?)
Message-ID: <20050112072501.GA6744@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
References: <41E2F823.1070608@apartia.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2F823.1070608@apartia.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent CARON <lcaron@apartia.fr>, on Mon Jan 10, 2005 [10:48:19 PM] said:
> Hello,
> 
> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
> growisofs.
> 
> It seems there is a problem
> 
> Here is the output
> 
> 
> # growisofs -Z /dev/scd0 -R -J ~/foobar
> 
> WARNING: /dev/scd0 already carries isofs!
> About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd 
> of=/dev/scd0 obs=32k seek=0'
> INFO:ingISO-8859-15 character encoding detected by locale settings.
>        Assuming ISO-8859-15 encoded filenames on source filesystem,
>        use -input-charset to override.
> Total translation table size: 0
> Total rockridge attributes bytes: 252
> Total directory bytes: 0
> Path table size(bytes): 10
> /dev/scd0: "Current Write Speed" is 4.1x1385KBps.
> :-[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
> :-( write failed: Input/output error
> 
> 
> Needless to say it works fine with 2.6.9
> 
> Am I missing something?
> 
> Thanks
> 
> Laurent

	Hi;

	Using 2.6.10... (this hasnt happend under previous kernels,
but I cant swear as to the last one I burned a dvd under.)
	I too had a strange thing happen when I just tried to burn a
dvd with growisofs. First, it didnt work as non-root. (failed
with unable to set MODE, no dmesg) So, I became root, and it burnt all
right. But then the media wouldnt eject when I hit the eject
button. As a regular user I used the 'eject' command, but it
failed. I ran 'eject' as root, and it claimed to fail, but
actually ejected the disc.
	We see this in dmesg:
program eject is using a deprecated SCSI ioctl, p lease convert it to SG_IO
scsi: unknown opcode 0x1e

	After this, though is when things get odd. Xine failed to play
any dvd in the drive-- well, it would play the menu intro, but fail when
you clicked on a title. mplayer did better, but bombed out when I tried
to seek, and the drive refused to eject the disc after using any of 
these programs by hitting the manual button, but required root to run
the 'eject' command. No dmesg errors.
	I rebooted and things work as expected with xine and mplayer
on the dvd drive now. I dont know if the burning process was responsible
for messing up the drive state, or if it was possibly that I had 
previously used the pktcdvd driver... since I notice that there was
a kernel pktcdvd thread running previously, and not now. I wish I
had thought to tear down the pktcdvd association before rebooting...
	Anyway, Ill probably burn another dvd soon, and see what happens.

Paul
set@pobox.com
	

