Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269729AbTGJXrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbTGJXpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:45:25 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:39768 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269723AbTGJXoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:44:54 -0400
Message-ID: <3F0DFCC6.3000609@rackable.com>
Date: Thu, 10 Jul 2003 16:54:46 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Steven Dake <sdake@mvista.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <Pine.SOL.4.30.0307110132220.7938-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307110132220.7938-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 23:59:34.0061 (UTC) FILETIME=[4F9B85D0:01C3473F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>
>>
>>    
>>
>>>       for (port = 0; port <= 1; ++port) {
>>>               ide_pci_enablebit_t *e = &(d->enablebits[port]);
>>>
>>>               /*
>>>                * If this is a Promise FakeRaid controller,
>>>                * the 2nd controller will be marked as
>>>                * disabled while it is actually there and enabled
>>>                * by the bios for raid purposes.
>>>                * Skip the normal "is it enabled" test for those.
>>>                */
>>>               if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>>>                    ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
>>>                     (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
>>>                   (secondpdc++==1) && (port==1))
>>>                       goto controller_ok;
>>>      
>>>
>
>I think this test in reality does something different then comment states.
>

  This seems to be a theme with the pdc comments in general.

>
>For first port of PDC20262/65 this test increases secondpdc variable
>(so it is 1 after test). For second port this test is true
>(its PDC20262/65 && secondpdc == 1 && port == 1) so we don't test whether
>2nd port (not controller!) of 1st controller is enabled.
>
>Or I am reading it wrong?
>
>  
>
  Don't look at me.  I come to a different conclusion every time I read 
it.  Rereading it a couple of times would seem support your theroy.  
Which makes me wonder why Steven's patch works at all.  Unless for some 
reason the second port needs to be enabled for things to work.  Which 
begs the question why they didn't just test for an odd numbered channel.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


