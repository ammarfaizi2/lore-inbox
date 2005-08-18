Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVHRGlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVHRGlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVHRGlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:41:31 -0400
Received: from server2k3.home.biaachmonkie.com ([66.159.248.47]:42379 "EHLO
	wild1.rincewind.tv") by vger.kernel.org with ESMTP id S1750821AbVHRGla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:41:30 -0400
Message-ID: <43042D94.4030303@rincewind.tv>
Date: Wed, 17 Aug 2005 23:41:24 -0700
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv> <4303CEC5.3010502@trash.net>
In-Reply-To: <4303CEC5.3010502@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

> Ollie Wild wrote:
>
>> If the ip_append_data() call in icmp_push_reply() fails, 
>> ip_flush_pending_frames() needs to be called.  Otherwise, ip_rt_put() 
>> is never called on inet_sk(icmp_socket->sk)->cork.rt, which prevents 
>> the route (and net_device) from ever being freed.
>
>
> Your patch doesn't fit your description, the else-condition you're
> adding triggers when the queue is empty, so what is the point?

Since we're only calling ip_append_data() once here, the two conditions 
are identical.

Ollie
