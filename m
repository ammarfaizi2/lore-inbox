Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVE2UM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVE2UM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVE2UM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:12:56 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:38487 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVE2UMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:12:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=h+XapR5FE36j2l5Kv0JTp7ZKtSW8/bmppHJSVbf/QzbRFjAaRPbqXrPgN+H3jGDs1l0gXrgaRMac/kw06PH89+fjOpG96WVURI2tub6Yea8pwNsHfftt9gRQv69uD21Ne0hAPh/+3Kww1lBVbwNeFDKsu/mCEMso7aSXpR6cG3c=
Message-ID: <429A2238.8010604@gmail.com>
Date: Sun, 29 May 2005 22:12:40 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <20050529190259.GA29770@suse.de>
In-Reply-To: <20050529190259.GA29770@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe schrieb:

>On Sun, May 29 2005, Michael Thonke wrote:
>  
>
>>Jens Axboe wrote,
>>
>>    
>>
>>>There's really nothing to be tuned. If NCQ is enabled for your drive, it
>>>will be printed in dmesg after the lba48 flag, such as:
>>>
>>>ata1: dev 0 ATA, max UDMA/133, 488281250 sectors lba48 ncq
>>>
>>>If you don't see NCQ there, your drive/controller doesn't support it.
>>>Likewise you will have a queueing depth of > 1 if NCQ is enabled, check
>>>/sys/block/sdX/device/queue_depth to see what the configured queueing
>>>depth is for that device.
>>>
>>> 
>>>
>>>      
>>>
>>Hi Jens,
>>
>>thanks for the short info now my next question how many queue depths
>>are healty and wanted?
>>
>>For my Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage
>>Controllers cc=AHCI (rev 01)
>>and Samsung Hd160JJ SATAII drive the default queue is 30
>>
>>    ioGL64NX_MACH~# cat /sys/block/sda/device/{model,queue_depth}
>>    SAMSUNG HD160JJ
>>    30
>>
>>    hdparm -Tt /dev/sda
>>
>>    /dev/sda:
>>    Timing cached reads: 4724 MB in 2.00 seconds = 2360.00 MB/sec
>>    Timing buffered disk reads: 164 MB in 3.02 seconds = 54.28 MB/sec
>>
>>On random access the drives is a bit noisy but the subjective feeling
>>is great everything goes a bit faster.
>>    
>>
>
>You should see a nice performance improvement on random reads mainly,
>with streamed threaded reads being a bit faster as well. Write
>performance will be the same, if you had write back caching on before.
>So the real win is random reads, and that can be a pretty big win.
>
>Actually I would say that the drive should sound _less_ noisy if NCQ is
>being really effective. Hard to judge of course, very subjective :)
>
>  
>
Well the subjective feeling is great through! What I noticed is a
improvement on rsync (goes slighty faster drive to drive).
The noise decrease now it only make noise on very heavy IO reads and writes.

>>And whats about the option /sys/block/sdx/device/queue_type = simple
>>what can be done here?
>>    
>>
>
>Nothing, unfortunately NCQ doesn't provided any way of doing ordered
>tags. The only tunable is the queue_depth, you can set that anywhere
>between 1 and 30.
>
>  
>
So way my drive got default 30 as queue_depth on AHCI as you mentoined
in the next mail
2-4 should be suitable and enough/normal?


Thanks for the informations

Greets
    Michael
