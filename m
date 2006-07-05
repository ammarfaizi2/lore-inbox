Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWGELx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWGELx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWGELxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:53:55 -0400
Received: from mail.tmr.com ([64.65.253.246]:14293 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964828AbWGELxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:53:55 -0400
Message-ID: <44ABA8D5.3020907@tmr.com>
Date: Wed, 05 Jul 2006 07:56:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <17578.4725.914746.951778@cse.unsw.edu.au> <44AA262E.906@argo.co.il>
In-Reply-To: <44AA262E.906@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Neil Brown wrote:
>>
>> On Tuesday July 4, avi@argo.co.il wrote:
>> > Neil Brown wrote:
>> > >
>> > > To my mind, the only thing you should put between the filesystem and
>> > > the raw devices is RAID (real-raid - not raid0 or linear).
>> > >
>> > I believe that implementing RAID in the filesystem has many benefits 
>> too:
>> >  - multiple RAID levels: store metadata in triple-mirror RAID 1, random
>> > write intensive data in RAID 1, bulk data in RAID 5/6
>> >  - improved write throughput - since stripes can be variable size, any
>> > large enough write fills a whole stripe
>>
>> Maybe....
>>
>> Now imagine what would be required to rebuild a whole drive onto a
>> spare after a drive failure.
>>
>> I'm sure it is possible, and I believe ZFS does something like that.
>> I find it hard to imagine getting reasonable speed if there is much
>> complexity.  And the longer it takes, the longer your data is exposed
>> to multiple-failures.
>>
> 
> A company called Isilon does this on a cluster.  They claim (IIRC) a one 
> hour rebuild time for a failure.  AFAIK they rebuild into cluster free 
> space, so they are not bound by the spare's bandwidth; they can utilize 
> all cluster resources for a rebuild.
> 
> (You don't need spare disks, just spare free space; so you don't have 
> idle disk heads)
> 
Readers of the RAID list will recognize this description, it matches my 
comments on RAID5E (distributed hot spare) very well. And I suppose 
there could be RAID6E as well, although I haven't really thought about it.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

