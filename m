Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264307AbRFLKqc>; Tue, 12 Jun 2001 06:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264312AbRFLKqN>; Tue, 12 Jun 2001 06:46:13 -0400
Received: from motgate3.mot.com ([144.189.100.103]:7323 "EHLO motgate3.mot.com")
	by vger.kernel.org with ESMTP id <S264307AbRFLKpx>;
	Tue, 12 Jun 2001 06:45:53 -0400
Message-Id: <3B25F227.5A5EEBB4@crm.mot.com>
Date: Tue, 12 Jun 2001 12:42:47 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: sk_buff allocation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing a module that is able to modify outgoing packets.
This is done by registering a new entry in ptype_all.
But my problem is that in dev_queue_xmit_nit the sk_buff is
cloned and that my function get this clone. So my modification
on skb->data isn't take into account by the ethernet driver.

My idea was to do my modifications and then copy all my datas
starting at skb->data so that nothing in the sk_buff is modified.

But what am I doing if the buffer doesn't have enough room to
support the new/modified data ?
skb_cow or skb_copy_expand, for example, will return me a new
sk_buff with a new buffer but how could I tell the system that
it must "replace" the old sk_buff by this one ?

Thanks

-Emmanuel Varagnat
