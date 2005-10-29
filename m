Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVJ2M2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVJ2M2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 08:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVJ2M2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 08:28:03 -0400
Received: from main.gmane.org ([80.91.229.2]:46509 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750834AbVJ2M2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 08:28:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Notifier chains are unsafe
Date: Sat, 29 Oct 2005 08:25:04 -0400
Message-ID: <djvpme$p83$1@sea.gmane.org>
References: <5600736.1130346691049.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <E1EUxn7-00081k-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <E1EUxn7-00081k-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Andreas Kleen <ak@suse.de> wrote:
> 
>>Am Mi 26.10.2005 02:01 schrieb Chandra Seetharaman
>><sekharan@us.ibm.com>:
>>
>>
>>>>Better would be likely to use RCU.
>>>
>>>RCU will be a problem if the registered notifiers need to block.
>>
>>?
>>Actually blocking should be ok, as long as the blocking notifier doesn't
>>unregister
>>itself. The current next pointer will be always reloaded after the
>>blocking.
> 
> 
> Blocking would be OK as long as you reference count the objects.


With or without RCU?  I.e., it's just a straighforward reference counting
solution and RCU is being used to allow incrementing the reference counts
safely.  Otherwise, without RCU you'd need a lock to safely increment the
reference counts.  Also note that with reference counting, the deletes of
the objects can occur any time a reference count is decremented.  So that
would include the notify_call threads as well.

--
Joe Seigh

