Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUEPVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUEPVRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUEPVRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:17:07 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:56550 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S264824AbUEPVRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:17:02 -0400
Message-ID: <40A7D9E6.1090900@keyaccess.nl>
Date: Sun, 16 May 2004 23:15:18 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl> <20040516195811.GH20505@devserv.devel.redhat.com> <200405162220.23971.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405162220.23971.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> On Sunday 16 of May 2004 21:58, Alan Cox wrote:
> 
>>On Fri, May 14, 2004 at 01:58:58PM +0200, Rene Herman wrote:
>>
>>>Have again attached a 'rollup' patch against vanilla 2.6.6, including
>>>this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of
>>>spindle if rebooting" hack. Again, just in case anyone finds it useful.
>>
>>This reintroduces corruption on my thinkpad 600.
> 
> [ this corruption was fixed by kernel 2.6.6 ]
> 
> Please see if reverting changes to ide_device_shutdown() helps.

Bart, could something like:

if (system_state == SYSTEM_RESTART) {
	ide_cache_flush_p(drive)
	return;
}

(as opposed to just the return in that patch and -mm3) possibly help? I 
sort of expect that ide_cache_flush_p() is already called further on up?

Alan, if you know, that drive fails ide_id_has_flush_cache()?

Note, very aware I don't know what the fuck I'm doing here (and equally 
aware I don't _want_ to be here :-) Having the drive spin down on each 
reboot is totally unacceptable though. Not only does spinning up again 
take significant time and noise, it's also actively bad for the drive.

If there's no sane way to fix this, an explicit blacklist for drives 
that really need to be shutdown? Eew.

Rene.
