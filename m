Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVCBWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVCBWJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVCBWHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:07:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:20150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261402AbVCBVw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:52:28 -0500
Date: Wed, 2 Mar 2005 13:51:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050302135146.2248c7e5.akpm@osdl.org>
In-Reply-To: <31789.1109799287@redhat.com>
References: <20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> The attached patch does two things:
> 
>  (1) It gets rid of backing_dev_info::memory_backed and replaces it with a
>      pair of boolean values:
> 
> 	(*) dirty_memory_acct
> 
> 	    True if the pages associated with this backing device should be
> 	    tracked by dirty page accounting.
> 
>         (*) writeback_if_dirty
> 
> 	    True if the pages associated with this backing device should have
> 	    writepage() or writepages() invoked upon them to clean them.

Cool, thanks.

>  (2) It adds a backing device capability mask that indicates what a backing
>      device is capable of; currently only in regard to memory mapping
>      facilities. These flags indicate whether a device can be mapped directly,
>      whether it can be copied for a mapping, and whether direct mappings can
>      be read, written and/or executed. This information is primarily aimed at
>      improving no-MMU private mapping support.
> 
> ...

> +#define BDI_CAP_MAP_COPY	0x00000001	/* Copy can be mapped (MAP_PRIVATE) */
> +#define BDI_CAP_MAP_DIRECT	0x00000002	/* Can be mapped directly (MAP_SHARED) */

Why not make these bitfields as well?

