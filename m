Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUEJVh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUEJVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUEJVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:37:57 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:25360 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261865AbUEJVh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:37:56 -0400
Date: Mon, 10 May 2004 22:37:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510223755.A7773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 02:45:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +hugetlb_shm_group-sysctl-patch.patch
> 
>  Add /proc/sys/vm/hugetlb_shm_group: this holds the group ID of users who may
>  allocate hugetlb shm segments without CAP_IPC_LOCK.  For Oracle.
> 
> +mlock_group-sysctl.patch
> 
>  /proc/sys/vm/mlock_group: group ID of users who can do mlock() without
>  CAP_IPC_LOCK.  Not sure that we need this.

These two just introduced a subtile behaviour change during stable series,
possibly (not likely) leading to DoS opportunities from applications running
as gid 0.  Really, with capabilities first and now selinux we have moved
away from treating uid 0 special, so introducing special casing of a gid
now is more than just braindead.

