Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVDDM1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDDM1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 08:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVDDM1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 08:27:52 -0400
Received: from mail0.lsil.com ([147.145.40.20]:2520 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261227AbVDDM1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 08:27:48 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57036627A6@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'Sergio Chiesa'" <sergio.chiesa@eutelia.it>, linux-kernel@vger.kernel.org
Subject: RE: Followup: PROBLEM: Kernel bug at tg3.c:2456
Date: Mon, 4 Apr 2005 08:27:32 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 31, 2005 7:34 AM, Sergio wrote:
> I made some tests again, switching back to the onboard dual 
> aic7902 scsi 
> controller (non raid) the tg3 dont hung anymore.
> I just noticed the IRQ mappings change between the two settings.
> The Broadcom eth get always the IRQ #25, the two onboard scsi 
> controllers 
> get #24 and #25 (shared with the eth, is it harmful??) but 
> the megaraid 
> driver gets the IRQ #28
Can you please specify megaraid driver version?
It seems the megaraid driver gets unique IRQ and the IRQ dedicated to the
MegaRAID controller.
I don't see any problem concerning IRQ at this time. Difference of
performance in between MegaRAID and Adaptec can contribute the issue.

> Usually there
> are no messages on screen, but the last time I get "Kernel bug at
> tg3.c:2456"!! on the sender. The skb pointer in the tx_ring_info was
> null.... May it be queue overrun?
I would suggest to look into the issue from above perspective. 

Thank you.

Seokmann
LSI Logic Corporation.


> -----Original Message-----
> From: Sergio Chiesa [mailto:sergio.chiesa@eutelia.it] 
> Sent: Thursday, March 31, 2005 7:34 AM
> To: linux-kernel@vger.kernel.org
> Subject: Followup: PROBLEM: Kernel bug at tg3.c:2456
> 
> Sergio Chiesa wrote:
> 
> > 7.7.
> > Well, it seems that with the original onboard raid 
> controller the bug
> > didn't trigger... the controller was swapped with the lsi 
> logic by my
> > supplier because it fails badly with raid-5 arrays (hw/fw 
> related issue)
> > I also tried the original broadcom driver version 7.3.5 with similar
> > results...
> 
> I made some tests again, switching back to the onboard dual 
> aic7902 scsi 
> controller (non raid) the tg3 dont hung anymore.
> I just noticed the IRQ mappings change between the two settings.
> The Broadcom eth get always the IRQ #25, the two onboard scsi 
> controllers 
> get #24 and #25 (shared with the eth, is it harmful??) but 
> the megaraid 
> driver gets the IRQ #28
> 
> I think it is something IRQ related because if the eth hungs 
> but the kernel 
> is still running I see more than 140000 irq per second with "vmstat".
> 
> Hope it helps better!
> 
> Sergioc.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
