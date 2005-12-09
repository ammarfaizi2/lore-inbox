Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVLIBw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVLIBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVLIBw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 20:52:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:54956 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750961AbVLIBw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 20:52:56 -0500
Message-ID: <4398E364.6050605@pobox.com>
Date: Thu, 08 Dec 2005 20:52:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc5-mm1
References: <20051204232153.258cd554.akpm@osdl.org> <4398D967.4020309@ums.usu.ru>
In-Reply-To: <4398D967.4020309@ums.usu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alexander E. Patrakov wrote: > Andrew Morton wrote: >
	>>
	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
	>> > > > I just noticed (maybe too late) that this kernel has the
	"pata_via" > driver and decided to try it. It works here, but has one
	drawback: it is > slower than the old "via82cxxx" IDE driver. > > My
	configuration with the via82cxxx driver: > > /dev/hda = disk, QUANTUM
	FIREBALLlct20 > Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1 > >
	/dev/hdb = SAMSUNG CD-ROM SC-148F > Drive is old, supports only mdma2 >
	> There are also /dev/hdc and /dev/hdd, irrelevant here. > > With the
	via82cxxx driver, I can get speed around 20 MB/s from /dev/hda. > The
	pata_via driver downgrades this to 7 MB/s because it needlessly > drops
	the disk to MWDMA2 mode. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Andrew Morton wrote:
> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/ 
>>
> 
> 
> I just noticed (maybe too late) that this kernel has the "pata_via" 
> driver and decided to try it. It works here, but has one drawback: it is 
> slower than the old "via82cxxx" IDE driver.
> 
> My configuration with the via82cxxx driver:
> 
> /dev/hda = disk, QUANTUM FIREBALLlct20
> Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1
> 
> /dev/hdb = SAMSUNG CD-ROM SC-148F
> Drive is old, supports only mdma2
> 
> There are also /dev/hdc and /dev/hdd, irrelevant here.
> 
> With the via82cxxx driver, I can get speed around 20 MB/s from /dev/hda. 
> The pata_via driver downgrades this to 7 MB/s because it needlessly 
> drops the disk to MWDMA2 mode.

That's expected, as libata currently limits all drives on a bus to the 
maximum speed of the slowest drive.  That's needed by some controllers, 
but not all.

I'm pretty sure Alan plans to fix that (at least ISTR him mentioning it).

	Jeff


