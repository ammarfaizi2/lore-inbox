Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbUKGT4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbUKGT4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbUKGT4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:56:36 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:47578 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261592AbUKGT4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:56:33 -0500
Message-ID: <418E7CD7.408@keyaccess.nl>
Date: Sun, 07 Nov 2004 20:51:51 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ondrej Zary <linux@rainbow-software.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: cdu31a - anyone has this ancient drive for testing?
References: <418E4A27.2060104@rainbow-software.org>
In-Reply-To: <418E4A27.2060104@rainbow-software.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zary wrote:

> I've got a Sony CDU33A drive with COR334 controller. The Linux cdu31a 
> driver was not updated for 2.6 kernel so it does not work.

Well, modular it still /pretended/ to work. That is, it could (most of 
the time) mount CD-ROMs but yes, most any actual activity made it blow up...

> Here are two patches that try to make the driver working with 2.6 
> kernel. The cdu31a-timeouts-fix.patch fixes the timeout values in header 
> file and the cdu31a-make-working.patch does the rest:
>  - Make the driver work in 2.6.X
>  - Added workaround to fix hard lockups on eject
>  - Fixed door locking problem after mounting empty drive
>  - Set double-speed drives to double speed by default
>  - Removed all readahead things - not needed anymore
> 
> It does work on my system. I also know that it's still broken - it uses 
> cli(), MODULE_PARM and it's also not very fast (I _never_ reached full 
> 300KB/s with it, but I know that it's possible in Windows) and probably 
> many other things (I'm new to Linux kernel) - so I'm waiting for comments.
> 
> If someone has these ancient drives (CDU31A or CDU33A), please test :-)

Verified to do useful things here as well. I Have a CDU33A connected 
through a MediaVision PAS16 soundcard:

Pro Audio Spectrum driver Copyright (C) by Hannu Savolainen 1993-1996
<Pro AudioSpectrum 16D rev 127> at 0x388 irq 10 dma 5
Leaving handle_sony_cd_attention at 1004
Sony I/F CDROM : SONY     CD-ROM CDU33A    Rev 1.0c
   Capabilities: tray, audio, eject, LED, elec. Vol, sep. Vol, double speed
Entering sony_get_toc
[ a great many leaving/entering and other debug printks ]

and I could actually mount CD-ROMs and copy stuff from them. One thing, 
a full 'dd' does not work:

root@5vd5:~# dd if=/dev/sonycd of=test.iso
0+0 records in
0+0 records out
root@5vd5:~# ls -l test.iso
-rw-r--r--  1 root root 0 2004-11-07 20:41 test.iso

no oopses, nor specific complaints in dmesg.

Good job though, as far as I'm concerned. Once you have a final version, 
you may want to submit this directly to Linus or maybe to Al Viro. He 
sometimes looks at these drivers. I added him to the CC...

Rene.
