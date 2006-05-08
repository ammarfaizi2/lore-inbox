Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWEHVRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWEHVRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWEHVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:17:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750936AbWEHVRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:17:42 -0400
Date: Mon, 8 May 2006 14:19:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
Message-Id: <20060508141952.2d4b9069.akpm@osdl.org>
In-Reply-To: <20060502061408.GM13962@in.ibm.com>
References: <20060502061408.GM13962@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> @@ -550,6 +550,12 @@ struct task_delay_info {
>  	 * Atomicity of updates to XXX_delay, XXX_count protected by
>  	 * single lock above (split into XXX_lock if contention is an issue).
>  	 */
> +
> +	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
> +	u64 blkio_delay;	/* wait for sync block io completion */
> +	u64 swapin_delay;	/* wait for swapin block io completion */
> +	u32 blkio_count;
> +	u32 swapin_count;

These fields are a bit mystifying.

In what units are blkio_delay and swapin_delay?

What is the meaning behind blkio_count and swapin_count?

Better comments needed, please.
