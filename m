Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVDDRIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVDDRIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDDRIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:08:02 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:2110 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261292AbVDDRHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:07:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=BvjS5pL94Kl3N0OUVyrUNCI3YBl/wpcePK6+jEVxkxOQG7bLf7nHBEyYc13xHlSB0UxYJ/ao0989UHo3wRtjfRu8WevOdmMBEnhUwqGS2ddhjYKRXYnNFRzGFrUJEc2QpAfTQRTxrg7TLPBiRr8B2JBvsbn7NtYYW8w3cLagbIU=
Message-ID: <42517449.9050808@gmail.com>
Date: Mon, 04 Apr 2005 19:07:21 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: kladit@t-online.de
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc1-bk6 boot problem
References: <20050404161352.GA15412@xeon2.local.here>
In-Reply-To: <20050404161352.GA15412@xeon2.local.here>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de wrote:

>Dual P4 (Tyan S2662/I7505)
>
>Booting of 2.6.12-rc1-bk6 stops after these lines ..
>
>..
>Enabling IO-APIC IRQs
>.. TIMER; vector=0x31 oin1=2 pin2=-1
>checking TSC synchronization across 4 CPUs: passed
>Brought up 4 CPUs
>
>2.6.12-rc1 works.
>Please cc me, I am not subscribed.
>  
>
Hello kladit,

Searching on lkml.org show
The fix was posted yesterday again.

http://lkml.org/lkml/2005/4/3/74

===== net/core/sock.c 1.67 vs edited =====
--- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
+++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
@@ -1352,7 +1352,7 @@
 
 EXPORT_SYMBOL(sk_common_release);
 
-static rwlock_t proto_list_lock;
+static DEFINE_RWLOCK(proto_list_lock);
 static LIST_HEAD(proto_list);
 
 int proto_register(struct proto *prot, int alloc_slab)

Best regards

Mit freundlichen Grüßen

M.Thonke


