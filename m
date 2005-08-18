Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVHRSmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVHRSmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVHRSmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:42:55 -0400
Received: from [62.206.217.67] ([62.206.217.67]:16600 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S932351AbVHRSmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:42:55 -0400
Message-ID: <4304D6AC.4060606@trash.net>
Date: Thu, 18 Aug 2005 20:42:52 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ollie Wild <aaw@rincewind.tv>
CC: linux-kernel@vger.kernel.org, Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv> <4303CEC5.3010502@trash.net> <43042D94.4030303@rincewind.tv>
In-Reply-To: <43042D94.4030303@rincewind.tv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ollie Wild wrote:
> Patrick McHardy wrote:
> 
>> Ollie Wild wrote:
>>
>>> If the ip_append_data() call in icmp_push_reply() fails,
>>> ip_flush_pending_frames() needs to be called.  Otherwise, ip_rt_put()
>>> is never called on inet_sk(icmp_socket->sk)->cork.rt, which prevents
>>> the route (and net_device) from ever being freed.
>>
>> Your patch doesn't fit your description, the else-condition you're
>> adding triggers when the queue is empty, so what is the point?
> 
> Since we're only calling ip_append_data() once here, the two conditions
> are identical.

You're right, I misread your patch. It would be easier to understand
if you just checked the return value of ip_append_data, as done in
udp.c or raw.c.
