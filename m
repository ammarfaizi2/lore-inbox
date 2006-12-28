Return-Path: <linux-kernel-owner+w=401wt.eu-S965037AbWL1WnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWL1WnM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWL1WnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:43:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38355 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbWL1WnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:43:10 -0500
Date: Thu, 28 Dec 2006 14:42:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 3/8] Routines to initialize and test a wait bit
 key
Message-Id: <20061228144243.a54046dc.akpm@osdl.org>
In-Reply-To: <20061228083900.GC6971@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
	<20061228083900.GC6971@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 14:09:00 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> +#define init_wait_bit_key(waitbit, word, bit)				\
> +	do {								\
> +		(waitbit)->key.flags = word;				\
> +		(waitbit)->key.bit_nr = bit;				\
> +	} while (0)
> +
> +#define init_wait_bit_task(waitbit, tsk)				\
> +	do {								\
> +		(waitbit)->wait.private = tsk;				\
> +		(waitbit)->wait.func = wake_bit_function;		\
> +		INIT_LIST_HEAD(&(waitbit)->wait.task_list);		\
> +	} while (0)

Can we convert these to C functions (inlined or regular, probably inlined
would be better)?
