Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbTGJWmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269635AbTGJWmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:42:50 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:23377 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269637AbTGJWls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:41:48 -0400
Message-ID: <3F0DEDFD.5040805@rackable.com>
Date: Thu, 10 Jul 2003 15:51:41 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Dake <sdake@mvista.com>
CC: Chad Kitching <CKitching@powerlandcomputers.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <18DFD6B776308241A200853F3F83D507279B@pl6w2kex.lan.powerlandcomputers.com> <3F0DE61B.1020207@rackable.com> <3F0DE8CF.9060808@mvista.com>
In-Reply-To: <3F0DE8CF.9060808@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 22:56:28.0764 (UTC) FILETIME=[7F6509C0:01C34736]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Dake wrote:

> Even with special fasttrack feature enabled, my disk devices on the 
> PDC20276 is not found.  There is code in pci-setup.c which blocks 
> other PDC controllers, why not the 20276?  Is that code for some other 
> purpose, or orthagonal to the force option?

  The comments would seem to indicate that this is only needed if you 
have a second controller.  Which leads me to wonder what if I have 3 or 
4 pdc controllers.

        for (port = 0; port <= 1; ++port) {
                ide_pci_enablebit_t *e = &(d->enablebits[port]);

                /*
                 * If this is a Promise FakeRaid controller,
                 * the 2nd controller will be marked as
                 * disabled while it is actually there and enabled
                 * by the bios for raid purposes.
                 * Skip the normal "is it enabled" test for those.
                 */
                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
                    (secondpdc++==1) && (port==1))
                        goto controller_ok;






-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


