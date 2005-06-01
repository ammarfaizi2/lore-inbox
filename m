Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFAW3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFAW3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFAW3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:29:31 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:57273 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261334AbVFAW1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:27:06 -0400
Message-ID: <429E359D.8090701@keyaccess.nl>
Date: Thu, 02 Jun 2005 00:24:29 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, Mark Lord <lkml@rtr.ca>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <429E0965.1090809@vc.cvut.cz> <429E1049.20903@keyaccess.nl> <200506011337.29656.david-b@pacbell.net>
In-Reply-To: <200506011337.29656.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>Added EHCI maintainer to this one as well. If possible, this looks like 
>>a good candidate for a /proc or /sys knob?
> 
> 
> No, it's based on a mis-understanding of the hardware.
> 
> The controller should only be doing DMA when some driver has submitted
> an URB and that URB hasn't yet completed.  Pretty much like any other
> hardware, like a disk or network controller.

Okay, thanks, and okay, crap. Sounded like a nice, plausible explanation...

> For periodic transfers -- interrupt, isochronous, neither used for
> disk I/O -- the driver issuing the transfer always has control over
> the polling period.  But that's mostly related to the USB activity;
> if a periodic transfer is active, then the current segment of the
> periodic schedule has to be scanned (by DMA) every microframe (8x/msec).
> If that segment is empty, that's just one word (32 bits).  If there
> are transfers, it's got to read them and maybe perform them.

I see. Well, sort of at least. "Even if the HDD were using periodic 
transfers, which it isn't, it would be DMAing 32-bits 8x per msec while 
idle, which certainly isn't going to cost 8MB/s bus bandwidth". Right?

Rene.
