Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUHSPJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUHSPJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUHSPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:06:16 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:50364 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266479AbUHSPEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:04:36 -0400
Message-ID: <4124C135.7050200@rtr.ca>
Date: Thu, 19 Aug 2004 11:03:17 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF37E.7070001@pobox.com> <41201DCA.2090204@rtr.ca> <4120E693.8070700@pobox.com>
In-Reply-To: <4120E693.8070700@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But HDIO_DRIVE_CMD is rather easy to implement as well,
>> and perhaps both should be there for an overlap.
>>
>> Especially since the former is in rather widespread use right now.
>> Yup, it's missing a separate data-phase parameter,
>> and lots of taskfile stuff, but it's configured by default
>> into every kernel (the same is not true for taskfile support),
>> and there's really only a few limited cases of it being used
>> for non-data commands:  IDENTIFY, SMART, and the odd READ/WRITE
>> SECTOR (pio, single sector).
> 
> 
> If HDIO_DRIVE_CMD was easy to do, I would have already done it.  I agree 
> with you that supporting it has benefits, but you are ignoring the 
> obstacles:

"Ignoring"?  Hardly.  I even listed a few of them above.
But in practice, HDIO_DRIVE_CMD only requires support for a very
limited set of commands.  It was never intended for arbitrary
command acceptance.  And it's not like Joe User can abuse it,
since it requires SYSADMIN and RAWIO capabilities to execute.

The command subset that accounts for just about all uses of it today is:

SET_FEATURES, SMART, IDENTIFY, READ_SECTOR, WRITE_SECTOR.
Period.

Pretty easy to support those, especially in SATA.
I know, since I've just taken a couple of hours and added it
to my SATA/RAID driver (a queuing controller with tag support).

For more generic interface, Curtis's document looks rather good.
But for backward compatibility with existing tools like the
smartmontools and hdparm, all that is needed is a limited subset
of HDIO_DRIVE_CMD (for the opcodes listed above) and also
the closely related HDIO_DRIVE_TASK ioctl for some of the SMART
commands (all non-data).

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
