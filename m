Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVJQRLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVJQRLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJQRLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:11:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58766 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751059AbVJQRLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:11:11 -0400
Message-ID: <4353DB2C.10905@pobox.com>
Date: Mon, 17 Oct 2005 13:11:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org> <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org> <Pine.LNX.4.64.0510170946250.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510170946250.23590@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Oct 2005, Linus Torvalds wrote:
> 
>>> And then with the quirk issue out of
>>>the way, CONFIG_SCSI_SATA becomes purely a boolean enable/disable-this-menu
>>>switch.
>>
>>No it does not. You continue to ignore the fact that it's not an 
>>enable/disable thing. It's a "can we enable SATA drivers" vs "can we 
>>enable SATA drivers as modules" vs "do we do any SATA drivers at all?" 
>>thing.
>>
>>A tristate.
> 
> 
> Btw, if you want to have the _question_ always be y/n only, that's easy 
> enough to do, just make that one do
> 
> 	config SATA_MENU
> 		bool "Want to see SATA drivers"
> 		depends on SCSI != n
> 
> 	config SCSI_SATA
> 		tristate
> 		depends on SCSI && SATA_MENU
> 		default y
> 
> and now you have a totally sensible setup, where the low-level drivers can 
> depend on something sane. 
> 
> I don't think it _buys_ you anything, but hey, at least it's logical. 

That's a reasonable solution.  I think it does buy you reduced user 
confusion.


> Btw, wouldn't it be much nicer to also have this all in a totally separate 
> Kconfig file? That SCSI Kconfig file is one of the biggest ones (yeah, 
> drivers/net/Kconfig is bigger, but hey, that's not a surprise, is it ;)

Honestly, I've been pondering moving all libata drivers to drivers/ata 
anyway...

	Jeff



