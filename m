Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266784AbUG1FLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUG1FLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUG1FLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:11:30 -0400
Received: from services.exanet.com ([212.143.73.102]:24584 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266784AbUG1FL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:11:26 -0400
Message-ID: <4107357C.9080108@exanet.com>
Date: Wed, 28 Jul 2004 08:11:24 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au>
In-Reply-To: <41070183.5000701@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 05:11:25.0207 (UTC) FILETIME=[54881270:01C47461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>
> There is some need arising for a call to set the PF_MEMALLOC flag for
> userspace tasks, so you could probably get a patch accepted. Don't
> call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or RECLAIM_HELPER.

I don't think my patch is general enough, it deals with only one level 
of dependencies, and doesn't work if the NFS server (or other process 
that kswapd depends on) depends on kswapd itself. It was intended more 
as an RFC than a request for inclusion.

It's probably fine for those with the exact same problem as us.

>
> But why is your NFS server needed to reclaim memory? Do you have the
> filesystem mounted locally?

Yes, for use by protocol adapters like samba.

Avi
