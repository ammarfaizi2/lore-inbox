Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUG0UXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUG0UXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUG0UXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:23:13 -0400
Received: from services.exanet.com ([212.143.73.102]:22247 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266611AbUG0UWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:22:47 -0400
Message-ID: <4106B992.8000703@exanet.com>
Date: Tue, 27 Jul 2004 23:22:42 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz>
In-Reply-To: <20040726210229.GC21889@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jul 2004 20:22:44.0043 (UTC) FILETIME=[793E91B0:01C47417]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>On heavy write activity, allocators wait synchronously for kswapd to
>>free some memory. But if kswapd is freeing memory via a userspace NFS
>>server, that server could be waiting for kswapd, and the system seizes
>>instantly.
>>
>>This patch (against RHEL 2.4.21-15EL, but should apply either 
>>literally
>>or conceptually to other kernels) allows a process to declare itself 
>>as
>>kswapd's little helper, and thus will not have to wait on kswapd.
>>    
>>
>
>Ok, but what if its memory runs out, anyway?
>
>  
>
Tough. What if kswapd's memory runs out?

A more complete solution would be to assign memory reserve levels below 
which a process starts allocating synchronously. For example, normal 
processes must have >20MB to make forward progress, kswapd wants >15MB 
and the NFS server needs >10MB. Some way would be needed to express the 
dependencies.

I think more and more people will hit this problem as filesystems become 
more complex due to clustering, and migrate to userspace where it can be 
more easily managed.

Avi
