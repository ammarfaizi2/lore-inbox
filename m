Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbTGJXMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbTGJXMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:12:54 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:14577 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S269688AbTGJXLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:11:24 -0400
Message-ID: <3F0DF5B8.9040304@mvista.com>
Date: Thu, 10 Jul 2003 16:24:40 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: Chad Kitching <CKitching@powerlandcomputers.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <18DFD6B776308241A200853F3F83D507279B@pl6w2kex.lan.powerlandcomputers.com> <3F0DE61B.1020207@rackable.com> <3F0DE8CF.9060808@mvista.com> <3F0DEDFD.5040805@rackable.com>
In-Reply-To: <3F0DEDFD.5040805@rackable.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samuel Flory wrote:

> Steven Dake wrote:
>
>> Even with special fasttrack feature enabled, my disk devices on the 
>> PDC20276 is not found.  There is code in pci-setup.c which blocks 
>> other PDC controllers, why not the 20276?  Is that code for some 
>> other purpose, or orthagonal to the force option?
>
>
>  The comments would seem to indicate that this is only needed if you 
> have a second controller.  Which leads me to wonder what if I have 3 
> or 4 pdc controllers.

Hmm thats not how I read the code.  My system has a standard IDE device 
as part of the chipset, and then also has a fasttrack controller.  The 
fasttrack controller comes in 2nd, (hence making it the 2nd controller 
and making it marked disabled).  I think your right about the 3rd/4th 
controller though, what happens to those !
-steve

>
>        for (port = 0; port <= 1; ++port) {
>                ide_pci_enablebit_t *e = &(d->enablebits[port]);
>
>                /*
>                 * If this is a Promise FakeRaid controller,
>                 * the 2nd controller will be marked as
>                 * disabled while it is actually there and enabled
>                 * by the bios for raid purposes.
>                 * Skip the normal "is it enabled" test for those.
>                 */
>                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
>                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
>                    (secondpdc++==1) && (port==1))
>                        goto controller_ok;
>
>
>
>
>
>

