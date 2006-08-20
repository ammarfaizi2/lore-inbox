Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWHTS6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWHTS6a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHTS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:58:30 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:32953 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751152AbWHTS63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:58:29 -0400
Message-ID: <44E8B08E.20507@colorfullife.com>
Date: Sun, 20 Aug 2006 20:57:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:

>> We're on UP.  sys_getsockopt() does get_user() (due to the patch) and
>> makes sure that the passed *optlen is sane.  Even if this get_user()
>> sleeps, the value it returns in "len" is what's currently in memory at
>> the time of the get_user() return (correct?)  Then an underlying
>> *getsockopt() function does another get_user() on optlen (same address),
>> without doing any other user-space data accesses or anything else that
>> could sleep first.  Is it possible that this second get_user()
>> invocation would sleep?  I think not since it's the same address that
>> we've just read a value from, we did not leave kernel space, and we're
>> on UP (so no other processor could have changed the mapping).  So the
>> patch appears to be sufficient for this special case (which is not
>> unlikely).
>
>this reasoning goes out the window with kernel preemption of course ;)
>  
>
Or O_DIRECT? I'm not sure what's easier to time, a kernel preemption or 
a DMA to the user address.

--
    Manfred

