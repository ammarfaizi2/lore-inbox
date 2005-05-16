Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVEPQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVEPQ5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVEPQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:57:05 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:44187 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261750AbVEPQ4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:56:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IIDc4DCxmnp05F/4FTUv3w31QoaMguRKhZyW/rmfwonZAS67cH9FG1V0v9UNj5z6iDT5CfHsJWf44MSIarTCjrR9PDCi+X1BofGvegAPd2ui9QaCLwAiyKZJBuy8oawF8GGM+TQhxf92EWSn+mlenAkjpb6bkb+waoLvvSyzDmk=
Message-ID: <4288D0D0.7070903@gmail.com>
Date: Tue, 17 May 2005 01:56:48 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary	scsi_wait_req_end_io()
References: <20050514135610.81030F26@htj.dyndns.org>	 <20050514135610.50606F9C@htj.dyndns.org>	 <1116084383.5049.18.camel@mulgrave> <20050514154733.GA5557@htj.dyndns.org>	 <1116087547.5049.25.camel@mulgrave> <20050515011532.GA26421@htj.dyndns.org> <1116259652.5040.17.camel@mulgrave>
In-Reply-To: <1116259652.5040.17.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sun, 2005-05-15 at 10:15 +0900, Tejun Heo wrote:
> 
>> I've made two new versions of the same patch.  The first one just
>>BUG() such cases, and the second one makes scsi_prep_fn() tell
>>scsi_request_fn() to kill requests instead of doing itself w/
>>BLKPREP_KILL.  In both cases, I made req->flags error case a BUG().
>>If you don't like it, feel free to drop that part.
>>
>> Oh... one more thing.  I forgot to mention the scsi_kill_requests()
>>path.  As it's a temporary fix, I just left it as it is (terminate
>>commands w/ end_that_*).  I guess this patch should be pushed after
>>removal of that kludge.  But with or without this patch, that path
>>will leak resources.
> 
> 
> I suppose it's not surprising that I don't like either.
> 
> You remove the code that handles the BLKPREP_KILL case and then contort
> the request functions to try not to do it.  We have to handle this case,
> it's not optional, so just leave the code that does it in.

 IMHO, as special request BLKPREP_KILL path is a kernel bug, code that
try to handle it normally is unnecessary, but it's your call.

 Thanks.

-- 
tejun
