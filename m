Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422865AbWHYUAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422865AbWHYUAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422883AbWHYUAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:00:07 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:41613 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422865AbWHYUAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:00:03 -0400
Date: Fri, 25 Aug 2006 22:04:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Howells <dhowells@redhat.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] [PATCH] BLOCK: Separate the bounce buffering code from the highmem code [try #4]
Message-ID: <20060825200455.GA2629@uranus.ravnborg.org>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193707.11384.97372.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825193707.11384.97372.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:37:07PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Move the bounce buffer code from mm/highmem.c to mm/bounce.c so that it can be
> more easily disabled when the block layer is disabled.
> 
> !!!NOTE!!! There may be a bug in this code: Should init_emergency_pool() be
> 	   contingent on CONFIG_HIGHMEM?
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  mm/Makefile  |    4 +
>  mm/bounce.c  |  302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/highmem.c |  281 ------------------------------------------------------
>  3 files changed, 305 insertions(+), 282 deletions(-)
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index 9dd824c..63637f0 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -12,6 +12,9 @@ obj-y			:= bootmem.o filemap.o mempool.o
>  			   readahead.o swap.o truncate.o vmscan.o \
>  			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
>  
> +ifeq ($(CONFIG_MMU),y)
> +obj-y			+= bounce.o
> +endif

CONFIG_MMU is a bool so you can do this much more elegant:
obj-$(CONFIG_MMU) += bounce.o


	Sam
