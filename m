Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267426AbUGNOTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267426AbUGNOTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267420AbUGNOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:18:14 -0400
Received: from zero.aec.at ([193.170.194.10]:26378 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267426AbUGNOH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:07:56 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: ipw2100 wireless driver
References: <2hQr1-62p-23@gated-at.bofh.it> <2hRQ5-7bn-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 14 Jul 2004 16:07:52 +0200
In-Reply-To: <2hRQ5-7bn-9@gated-at.bofh.it> (Vojtech Pavlik's message of
 "Wed, 14 Jul 2004 15:20:09 +0200")
Message-ID: <m3fz7usmvb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:
>
> Wouldn't "struct sk_buff **fragments" be a more correct fix?

No, that would be a pointer to an array instead of the array itself.

Completely different thing.

The best would be struct sk_buff *fragments[0]; 
[] here is C99, which 2.95 didn't even attempt to support.

-Andi


>> --- ipw2100-ofic/ieee80211.h	2004-07-09 06:32:17.000000000 +0200
>> +++ ipw2100-0.49/ieee80211.h	2004-07-14 13:18:50.000000000 +0200
>> @@ -440,7 +440,7 @@
>>  	u16 reserved;
>>  	u16 frag_size;
>>  	u16 payload_size;
>> -	struct sk_buff *fragments[];
>> +	struct sk_buff *fragments[1];

