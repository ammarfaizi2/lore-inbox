Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSILTKY>; Thu, 12 Sep 2002 15:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSILTKY>; Thu, 12 Sep 2002 15:10:24 -0400
Received: from relay.muni.cz ([147.251.4.35]:58520 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S316792AbSILTKW>;
	Thu, 12 Sep 2002 15:10:22 -0400
Date: Thu, 12 Sep 2002 21:14:52 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       kernel@street-vision.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX DMA lockup (partly solved)
Message-ID: <20020912211452.C29717@fi.muni.cz>
References: <20020912161258.A9056@fi.muni.cz> <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Sep 12, 2002 at 09:10:47PM -0200
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@street-vision.com wrote:
: Well I have run this several times on my MPX, and it is fine.
:
: This is 2.4.20-pre1, dual AMD 2000MP, only difference is it is the Tyan
: version of the MPX, not the MSI.
:
: Justin

        Justin, thanks for this! I've tried 2.4.20-pre1 with your
.config (and then with my .config), and it works!

        Further investigation showed that the problem first appeared
somewhere between 2.4.20-pre2 (works for me) and 2.4.20-pre5 (has the
lock-up problem I've described). I was not able to test -pre3 and -pre4,
because these kernel died on me during boot after the
"Initializing RT netlink socket" message.

	I the bug got merged from the -ac kernels, because it is
present bot in the kernel 2.4.19-11 from RedHat "null" beta
and in 2.4.20-pre2-ac1 (altough the later crashes instead of lock-up).

Denis Vlasenko wrote:
: 
: 8 GB... Can you make it loop over much lesser size?
: 
	with 2GB it still fails. I didn't try less, because with 1GB of RAM
it would not have any effect.

: I assume removing read+lseek eliminates lockup?

	Partly. I've tried 

dd if=/dev/hda3 of=/dev/null bs=1024k, and it still causes filesystem
corruption (altough no lockup).

: Is it IDE related or not? 
: If you can test it over SCSI/NFS/ramdisk/???...

	I think it is IDE or DMA related.

: > When I switch off the DMA (hdparm -d0 /dev/hda), the problem goes away
: > (however, the disk is very slow, as expected).
: 
: At which DMA/UDMA mode it starts to fail?

	-d1 -X33 fails.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
