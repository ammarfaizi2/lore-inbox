Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUIEEB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUIEEB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 00:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUIEEBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 00:01:55 -0400
Received: from wasp.net.au ([203.190.192.17]:12239 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266186AbUIEEBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 00:01:42 -0400
Message-ID: <413A8FD0.6090909@wasp.net.au>
Date: Sun, 05 Sep 2004 08:02:24 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>	<87u0ugt0ml.fsf@stark.xeocode.com> <413868CE.7070303@wasp.net.au>	<1094220595.7923.14.camel@localhost.localdomain> <87y8jppugw.fsf@stark.xeocode.com>
In-Reply-To: <87y8jppugw.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
>>>Jeff, do we really have to wait 30 seconds for a timeout? If the drive hits an unreadble spot I 
>>>would have thought it would come back to us with a read error rather than timing out the command.
>>
>>The drive will retry for a few seconds then fail. The failure now
>>generates a SCSI medium error to the core scsi layer and it does like to
>>issue a few retries. The default retry count for scsi is probably too
>>high for SATA given the drive retries.
> 
> 
> Certainly over an hour seems a little excessive:
> 
> $ time dd bs=512 count=1  if=/dev/sda4 of=/dev/null
> dd: reading `/dev/sda4': Input/output error
> 0+0 records in
> 0+0 records out
> 
> real    67m59.382s
> user    0m0.001s
> sys     0m0.002s

Yes. I noted that even when reading a single block, the block layer does a large read ahead request 
and the entire request times out block by block. I have been meaning to have a look at it and see 
what is required to get it to time out like SCSI/USB devices appear to (which is fail the entire 
request on error).

I'm also not sure there is not another issue lurking in there, but when it takes an hour to recover 
from a bad block read it does slow down testing somewhat ;p)

Regards,
Brad
