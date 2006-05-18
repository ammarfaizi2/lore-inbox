Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWERLBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWERLBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWERLBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:01:55 -0400
Received: from mexforward.lss.emc.com ([168.159.213.200]:38767 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751252AbWERLBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:01:54 -0400
Message-ID: <446C621E.9060502@emc.com>
Date: Thu, 18 May 2006 08:01:34 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>, Mark Lord <mlord@pobox.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.5.18.33113
X-PerlMx-Spam: Gauge=, SPAM=2%, Reason='EMC_FROM_0+ -2, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HIGHBITS 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_CRUFT 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord has been actively working on the sata_mv driver recently,

ric


Zang Roy-r61911 wrote:

>-----Original Message-----
>From: Kumar Gala [mailto:galak@kernel.crashing.org]
>Sent: 2006年5月17日 21:28
>To: Zang Roy-r61911
>Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Yang Xin-Xin-r48390
>Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerpc pl atform
>
>
>
>On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
>
>  
>
>>Fix Marvell SATA driver bugs on PowerPC platform:
>>SATA device can't work for the problem on little-endian mode.
>>U-Boot can't find SATA device after kernel reboots.
>>
>>Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
>>Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>
>>
>>    
>>
>>>From nobody Mon Sep 17 00:00:00 2001
>>>      
>>>
>>From: roy zang <tie-fei.zang@freescale.com>
>>Date: Tue May 16 15:25:23 2006 +0800
>>Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver
>>    
>>
>
>This needs to go to Jeff Garzik as SATA driver maintainer.
>
>- kumar
>
>  
>
>> drivers/scsi/sata_mv.c |   10 +++++++++-
>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>
>>d82ac19d259f8487a31105eaf844a93cbd9008e8
>>diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
>>index d5fdcb9..4166422 100644
>>--- a/drivers/scsi/sata_mv.c
>>+++ b/drivers/scsi/sata_mv.c
>>@@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16
>> {
>> 	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>> 		(last ? CRQB_CMD_LAST : 0);
>>+#ifdef CONFIG_PPC
>>+	*cmdw = cpu_to_le16(*cmdw);
>>+#endif
>> }
>>
>> /**
>>@@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>> static void mv5_enable_leds(struct mv_host_priv *hpriv, void  
>>__iomem *mmio)
>> {
>> 	u32 tmp;
>>-
>>+#ifndef CONFIG_PPC
>> 	writel(0, mmio + MV_GPIO_PORT_CTL);
>>+#endif
>>
>> 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>>
>> 	tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
>>+#ifdef CONFIG_PPC
>>+	tmp &= ~(1 << 0);
>>+#else	
>> 	tmp |= ~(1 << 0);
>>+#endif
>> 	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>> }
>>
>>-- 
>>1.3.0
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
