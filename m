Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932225AbWFDJNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWFDJNq (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWFDJNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:13:46 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:54896 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932223AbWFDJNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:13:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jL2L5XUFgG9QLdL4sBaFqiFzQUx/fH7DNNsdo+BFxXoMJ5IX0mjSWkwLBHPfMgUjlvL2EJBDNnk6732NI9ZAirQj5upKRMiIp6sSe/C0CqDiTdNmCB1u4M3fcyK/Eveod6d7hkY3H5RPG/k7EHdFo1S05o/B1LZbvXXzHQYH2l0=
Message-ID: <4482A436.8000703@gmail.com>
Date: Sun, 04 Jun 2006 18:13:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@suse.de>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/5] SCSI: add cpu cache flushes after kmapping and modifying
 a page
References: <1149392479501-git-send-email-htejun@gmail.com> <11493924803460-git-send-email-htejun@gmail.com> <20060604082035.GB29696@infradead.org>
In-Reply-To: <20060604082035.GB29696@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Jun 04, 2006 at 12:41:20PM +0900, Tejun Heo wrote:
>>  			local_irq_save(flags);
>>  			buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
>>  			memcpy(buf, tw_dev->generic_buffer_virt[request_id], sg->length);
>> +			flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
>>  			kunmap_atomic(buf - sg->offset, KM_IRQ0);
>>  			local_irq_restore(flags);
> 
> all these should switch to scsi_kmap_atomic_sg which should do the
> flush_kernel_dcache_page call for you.
> 

This is not specific to scsi or block.  This is a common problem for all 
kmap users.  As I wrote in the other mail, I think this should be 
mandated at the kmap/kunmap() interface.

-- 
tejun
