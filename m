Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVKLW2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKLW2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVKLW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:28:46 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:39596 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964816AbVKLW2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:28:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=r5wyMvA0HYwFQ5yW/ZJfFUlyj1c2s4V9VZldm+Rc7ycsq1fUXIpz80E4ZDRGD6VmXT6gJzSXpjkFqS/EeRxzTYcsviHFVbb7LmfY5udVuwFteIv7wMFo+djdxWc2pyjR/i0SLepzjqjI+AIAmV0A3nBzzO6ztz6KIlOop1ujVKM=
Message-ID: <43766C94.1060108@gmail.com>
Date: Sat, 12 Nov 2005 23:28:36 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm2 OOPS - packet writing
References: <6bffcb0e0511111601j6c53f646m@mail.gmail.com> <m3fyq2ug5h.fsf@telia.com>
In-Reply-To: <m3fyq2ug5h.fsf@telia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Peter Osterlund napisał(a):

>There is an old bug in the pkt_count_states() function that causes
>stack corruption. When compiling with gcc 3.x or 2.x it is harmless,
>but gcc 4 allocates local variables differently, which makes the bug
>visible. Fixed by this patch.
>
>Signed-off-by: Peter Osterlund <petero2@telia.com>
>---
>
> drivers/block/pktcdvd.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
>index 391ced8..b5f67b1 100644
>--- a/drivers/block/pktcdvd.c
>+++ b/drivers/block/pktcdvd.c
>@@ -1188,7 +1188,7 @@ static void pkt_count_states(struct pktc
> 	struct packet_data *pkt;
> 	int i;
> 
>-	for (i = 0; i <= PACKET_NUM_STATES; i++)
>+	for (i = 0; i < PACKET_NUM_STATES; i++)
> 		states[i] = 0;
> 
> 	spin_lock(&pd->cdrw.active_list_lock);
>
>  
>
Great thanks, patch fixed problem. Can you send it to Linus?

Regards,
Michal Piotrowski
