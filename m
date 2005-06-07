Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVFGBfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVFGBfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVFGBfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:35:10 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:31363 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261299AbVFGBfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:35:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WG52YJ9nNgXD2jSqf+FAmBlfpL2yDQ6EQ3oHqTokJrhAljrg3jIoeV+B2q+JeKmBdGDO2bt1ces28IBzXc1+hzeazyFlNh8W4wOcUKjzoDbF6/a97Q0WL+IDHF5/qg+YnN1iSCeUZ8cLdFZE5ZIT7hd8f12h/3Zv4LSPz/tRNIo=
Message-ID: <42A4F9BC.4040606@gmail.com>
Date: Tue, 07 Jun 2005 10:34:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 02/09] blk: make scsi use -EOPNOTSUPP
 instead of -EIO on ILLEGAL_REQUEST
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.215AB52C@htj.dyndns.org> <42A2A54B.9070607@pobox.com>
In-Reply-To: <42A2A54B.9070607@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> 02_blk_scsi_eopnotsupp.patch
>>
>>     Use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>  scsi_lib.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletion(-)
>>
>> Index: blk-fixes/drivers/scsi/scsi_lib.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/scsi_lib.c    2005-06-05 
>> 14:53:32.000000000 +0900
>> +++ blk-fixes/drivers/scsi/scsi_lib.c    2005-06-05 14:53:33.000000000 
>> +0900
>> @@ -849,7 +849,8 @@ void scsi_io_completion(struct scsi_cmnd
>>                  scsi_requeue_command(q, cmd);
>>                  result = 0;
>>              } else {
>> -                cmd = scsi_end_request(cmd, 0, this_count, 1);
>> +                cmd = scsi_end_request(cmd, -EOPNOTSUPP,
>> +                               this_count, 1);
> 
> 
> This looks like a change from zero to EOPNOTSUPP, but your description 
> says its a change from EIO to EOPNOTSUPP.
> 
>     Jeff
> 

  Hello, Jeff.

  I just found it confusing to write changing 0 to -EOPNOTSUPP when 0 
actually means -EIO (uptodate).  I'll write in more detailed way next time.

  Thank you. :-)

-- 
tejun
