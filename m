Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbUCTAmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUCTAmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:42:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63460 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263186AbUCTAmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:42:33 -0500
Message-ID: <405B936C.50200@pobox.com>
Date: Fri, 19 Mar 2004 19:42:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <200403200059.22234.bzolnier@elka.pw.edu.pl> <405B8CFD.2030909@pobox.com> <200403200140.59543.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403200140.59543.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 01:14, Jeff Garzik wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>The fact that spec says "supported" not "enabled" in description of
>>>word86 makes me wonder - can they be disabled? (FLUSH CACHE is mandatory
>>>for General feature set and FLUSH CACHE EXT is mandatory if 48-bit LBA is
>>>supported)
>>
>>Yes, that's why there are separate 'supported' and 'enabled' bits for
>>each feature.
>>
>>Words 82-84 are 'supported' bits.  Words 85-87 are 'enabled' bits.
>>These bits mirror each other, i.e. Word 83 and Word 86 have basically
>>the same bits, except that Word 86 definitions change _slightly_ since
>>the only bits that are relevant are the ones for features that can be
>>disabled/enabled.
>>
>>You use set-features command to enable and disable these features, and
>>then the result shows up in subsequent identify-device command output.
>>
>>If the driver is testing for a capability but does not enable it, then
>>always use the 'enabled' set of bits, not the 'supported' set of bits.
> 
> 
> This is quite obvious but I am talking about confusing wording in description
> of word86 - for some features 'enabled' is used and for others 'supported'

Yeah, mainly the difference is communicating in the description of each 
word.

Anyway, what I described is how things work :)  For example, features 
that are always enabled in the drive are listed with both support and 
enabled bits set.  The driver sees that, and does not issue a 
set-features command, because it does not need to.


>>>IMO to test if FLUSH CACHE works we should just issue it during disk
>>>setup and check result.  This way we can use FLUSH CACHE also on < ATA-6
>>>devices (there is a lot of them).
>>
>>I disagree.  "just issue it" is how those LG cdrom drives got cooked.
> 
> 
> I'm aware of LG fun.  Jens already stated that current barrier implementation
> is disk-only and I'm talking about disks only.
> 
> If anybody reused CACHE FLUSH opcode for disk drive he/she deserves to loose.
> 8)

Well...  If you don't check the proper feature bits found in the spec, I 
blame the driver for ignoring the spec...  :)


>>All drives that support flush-cache list the relevant bits in
>>identify-device, even on pre-ATA-6 devices.  Whether the feature was
>>optional or mandantory, we can check the feature bits.
> 
> 
> Hm. so this is undocumented in the spec?

?  When it was optional, there was a feature bit to test.  When it 
became mandantory, the feature bit to test stayed in there.  The feature 
bit is zero, otherwise.  Makes it possible to use "just test the bit" 
and have things Just Work(tm).  :)

	Jeff



