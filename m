Return-Path: <linux-kernel-owner+w=401wt.eu-S935964AbWLKOeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935964AbWLKOeG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936072AbWLKOeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:34:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46212 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935957AbWLKOeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:34:03 -0500
Message-ID: <457D6C4F.6090303@pobox.com>
Date: Mon, 11 Dec 2006 09:33:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
 DMA_NONE
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org> <200612111518.46887.arnd@arndb.de>
In-Reply-To: <200612111518.46887.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 11 December 2006 15:02, Tejun Heo wrote:
>>  {
>>         struct scatterlist sg;
>> +       unsigned int n_elem = 0;
>>  
>> -       sg_init_one(&sg, buf, buflen);
>> +       if (dma_dir != DMA_NONE) {
>> +               WARN_ON(!buf);
>> +               sg_init_one(&sg, buf, buflen);
>> +               n_elem++;
>> +       }
>>  
> Ok, looks good as well. I still think we should have the WARN_ON()
> in sg_set_buf(), but I can send a separate patch for that to linux-mm.

Please CC me and linux-ide on all libata patches (certainly akpm as 
well).  Andrew picks up most of the libata changes automatically via git 
from my libata-dev.git#ALL.

	Jeff



