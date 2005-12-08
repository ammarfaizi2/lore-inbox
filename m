Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVLHSXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVLHSXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVLHSXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:23:42 -0500
Received: from mbox1.netikka.net ([213.250.81.202]:16825 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S932231AbVLHSXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:23:41 -0500
Message-ID: <43987A28.8070509@mandriva.org>
Date: Thu, 08 Dec 2005 20:23:36 +0200
From: Thomas Backlund <tmb@mandriva.org>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: jgarzik@pobox.com
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
In-Reply-To: <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Bollinger wrote:
> On 12/3/05, Jeff Garzik <jgarzik@pobox.com> wrote:
>> To make it easy for others to test, since there are merge conflicts,
>> I've combined the two previous sata_sil patches into a single patch.
>>
>> Verified here on my 3112 (Adaptec 1210SA).
>>
>> I'm especially interested to hear from anyone willing to test on a
>> SI 3114 (4-port).
>>
>>
>> The 'sii' branch of
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> contains the following updates:
>>
>>  drivers/scsi/sata_sil.c |  233 +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 files changed, 219 insertions(+), 14 deletions(-)
>>
>> Jeff Garzik:
>>      [libata sata_sil] improved interrupt handling
>>      [libata sata_sil] Greatly improve DMA handling
>>
>> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
>> index 3609186..9e4630f 100644
>> --- a/drivers/scsi/sata_sil.c
>> +++ b/drivers/scsi/sata_sil.c
>> ...
> 
> Not so well on my Gigabyte GA-K8N Ultra 9.  lspci -v says:

Same for me...
After some more tests i managed to see some error output before the 
freeze, and this is what I also saw:

>> ata1: BUG: SG size underflow
>> ata1: status=0x50 { DriveReady SeekComplete }

and onde by one the raid devices got deactivated until the full freeze...
