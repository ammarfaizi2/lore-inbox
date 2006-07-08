Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWGHSAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWGHSAH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWGHSAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:00:07 -0400
Received: from mail.tmr.com ([64.65.253.246]:59872 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964925AbWGHSAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:00:05 -0400
Message-ID: <44AFF332.6040505@tmr.com>
Date: Sat, 08 Jul 2006 14:02:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Neil Brown <neilb@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <44ABAA0E.4000907@tmr.com> <44ABAC20.5090902@argo.co.il>
In-Reply-To: <44ABAC20.5090902@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Bill Davidsen wrote:
>>
>>
>> > Not syncing unused area is possible, if there was a way for raid resync
>> > to ask the fs what blocks are not in use.  I.e. get the
>> > free block list in disk block order.  Then raid resync could skip 
>> those.
>> >
>> Current RAID code supports having a bitmap of dirty stripes, and can
>> just sync those during recovery. I'm sure Neil could explain it better,
>> but this is available without worrying about fs type. Now. Today.
>>
> 
> This is only when the you reconstruct a disk that was once part of the 
> RAID.  If you are adding a brand new disk, all stripes are dirty.

I will leave Neil to explain this to you, it appears to be a totally 
different case for reconfiguration, but I don't pretend to understand 
the code well enough to clarify it.
> 
> This happens in two scenarios: an unclean RAID shutdown, and when you 
> have a remote mirror which can be disconnected by network problems.
> 
> If the RAID is integrated in the filesystem (or into an object storage 
> system), you can handle the new disk case too.
> 
I'm not sure that building the RAID into the filesystem is ever a good 
idea, it certainly seems likely to either prevent certain RAID devices 
from being used, or make them perform suboptimally. There are times when 
  being able to move a filesystem to a new device is REALLY useful, and 
byte copy is more practical than file by file copy.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
