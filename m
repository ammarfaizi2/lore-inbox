Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWEOLxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWEOLxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEOLxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:53:03 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:54023 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964894AbWEOLxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:53:02 -0400
Message-ID: <44686B99.8020805@argo.co.il>
Date: Mon, 15 May 2006 14:52:57 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <20060513160625.8848.76947.stgit@localhost.localdomain>
In-Reply-To: <20060513160625.8848.76947.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2006 11:52:59.0197 (UTC) FILETIME=[1CA72ED0:01C67816]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> There are allocations for which the main pointer cannot be found but they
> are not memory leaks. This patch fixes some of them.
>
>  
>  #include "util.h"
> @@ -389,6 +394,10 @@ void* ipc_rcu_alloc(int size)
>  	 */
>  	if (rcu_use_vmalloc(size)) {
>  		out = vmalloc(HDRLEN_VMALLOC + size);
> +#ifdef CONFIG_DEBUG_MEMLEAK
> +		/* avoid a false alarm. That's not a memory leak */
> +		memleak_free(out);
> +#endif
>   

Maybe add a function memleak_false_alarm() (which just calls 
memleak_free()) to document the fact that nothing is actually freed.

-- 
error compiling committee.c: too many arguments to function

