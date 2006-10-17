Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422996AbWJQE0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWJQE0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422991AbWJQE0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:26:35 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25470 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422954AbWJQE0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:26:34 -0400
Date: Mon, 16 Oct 2006 22:24:54 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4
In-reply-to: <45345015.2010601@rtr.ca>
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>,
       Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Message-id: <45345B16.4090505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
 <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk>
 <452F053B.2000906@shaw.ca> <20061013080434.GE6515@kernel.dk>
 <45344F4D.6070703@shaw.ca> <45345015.2010601@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Robert Hancock wrote:
>>
>> +/* ADMA Physical Region Descriptor - one SG segment */
>> +struct nv_adma_prd {
>> +    __le64            addr;
>> +    __le32            len;
>> +    u8            flags;
>> +    u8            packet_len;
>> +    __le16            reserved;
>> +};
> ..
>> +/* ADMA Command Parameter Block
>> +   The first 5 SG segments are stored inside the Command Parameter 
>> Block itself.
>> +   If there are more than 5 segments the remainder are stored in a 
>> separate
>> +   memory area indicated by next_aprd. */
>> +struct nv_adma_cpb {
>> +    u8            resp_flags;    //0
>> +    u8            reserved1;     //1
>> +    u8            ctl_flags;     //2
>> +    // len is length of taskfile in 64 bit words
>> +     u8            len;           //3 +    u8            
>> tag;           //4
>> +    u8            next_cpb_idx;  //5
>> +    __le16            reserved2;     //6-7
>> +    __le16            tf[12];        //8-31
>> +    struct nv_adma_prd    aprd[5];       //32-111
>> +    __le64            next_aprd;     //112-119
>> +    __le64            reserved3;     //120-127
>> +};
> 
> 
> Are those CPB / PRD structs endian-safe when using a big-endian CPU?
> 
> Cheers

They should be, I believe cpu_to_leXX is used whenever the multi-byte 
elements are being written. Not that anyone would likely install a 
big-endian CPU on an nForce4 chipset ;-)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
