Return-Path: <linux-kernel-owner+w=401wt.eu-S932217AbXAOLBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbXAOLBZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbXAOLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:01:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:52466 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbXAOLBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:01:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GQLrgHPibDTkSRnvrPEzNYl5aSPni+57VT/9cJupCN5yxjEm3WDKwVkAsGcojfMm4DL3s8M8TcLAHEaqr68RyBhmJC/r8uk43muXZ+lFsex3IRWaZDK1biIrzU3LwMGKDFTXxRZJhaKafCxroFSzkkb13G57LgXXxb5jbM/+1WM=
Message-ID: <661de9470701150301i7f315280p5ffa2b388e883f50@mail.gmail.com>
Date: Mon, 15 Jan 2007 16:31:23 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Roy Huang" <royhuang9@gmail.com>
Subject: Re: [PATCH] Provide an interface to limit total page cache.
Cc: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
In-Reply-To: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
X-Google-Sender-Auth: 4a28bbf66d9f8959
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Roy Huang <royhuang9@gmail.com> wrote:
> A patch provide a interface to limit total page cache in
> /proc/sys/vm/pagecache_ratio. The default value is 90 percent. Any
> feedback is appreciated.
>

[snip]

wakeup_kswapd and shrink_all_memory use swappiness to determine what to reclaim
(mapped pages or page cache).  This patch does not ensure that only
page cache is
reclaimed/limited. If the swappiness value is high, mapped pages will be hit.

One could get similar functionality by implementing resource management.

Resource  management splits tasks into groups and does management of
resources for the
groups rather than the whole system. Such a facility will come with a
resource controller for
memory (split into finer grain rss/page cache/mlock'ed memory, etc),
one for cpu, etc.

Balbir
