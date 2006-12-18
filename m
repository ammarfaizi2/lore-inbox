Return-Path: <linux-kernel-owner+w=401wt.eu-S1753965AbWLRNH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbWLRNH2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbWLRNH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:07:28 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:31168 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753969AbWLRNH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:07:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u4FdPnmXHzlMqYZR/TztsEpLzCML9l0hjst5BHmZCnv3dii6KssbTHt3tmYugk/l/AgvCIJIy0/TU4cnVHmvZv74ZxJ/YIcKus8dl+KscJDsW7iLy7wm1cokdYrhhVkHEAM8n5p7c6o5PoDHDb6QfIsJMm+xmQJWKBHZBN6bIxg=  ;
X-YMail-OSG: StRIUvUVM1kC6cryu3tReyDxVebXzsbDeWdmePM9bdgZ0nP66RTNLLGeVxYTL8lAWC6.qse4AcpuhgbFOFUbI9K3L.6pMp5YhL927VXkQYXMbB9JlyY0EN39I7hqj5QzWOqNFIptJCcO2.I-
Message-ID: <45868F7D.4020400@yahoo.com.au>
Date: Mon, 18 Dec 2006 23:54:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Manish Regmi <regmi.manish@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Linux disk performance.
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>	 <1166431020.3365.931.camel@laptopd505.fenrus.org> <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
In-Reply-To: <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Regmi wrote:
> On 12/18/06, Arjan van de Ven <arjan@infradead.org> wrote:
> 
>> if you want truely really smooth writes you'll have to work for it,
>> since "bumpy" writes tend to be better for performance so naturally the
>> kernel will favor those.
>>
>> to get smooth writes you'll need to do a threaded setup where you do an
>> msync/fdatasync/sync_file_range on a frequent-but-regular interval from
>> a thread. Be aware that this is quite likely to give you lower maximum
>> performance than the batching behavior though.
>>
> 
> Thanks...
> 
> But isn't O_DIRECT supposed to bypass buffering in Kernel?
> Doesn't it directly write to disk?
> I tried to put fdatasync() at regular intervals but there was no
> visible effect.
> 

I don't know exactly how to interpret the numbers you gave, but
they look like they might be a (HZ quantised) delay coming from
block layer plugging.

O_DIRECT bypasses caching, but not (all) buffering.

Not sure whether the block layer can handle an unplug_delay set
to 0, but that might be something to try (see block/ll_rw_blk.c).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
