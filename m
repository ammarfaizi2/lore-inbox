Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUH1WbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUH1WbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUH1WbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:31:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:24714 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268005AbUH1Waw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:30:52 -0400
Date: Sat, 28 Aug 2004 15:29:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2/5] consolidate bit waiting code patterns
Message-Id: <20040828152904.4721522c.akpm@osdl.org>
In-Reply-To: <20040828200841.GT5492@holomorphy.com>
References: <20040828200549.GR5492@holomorphy.com>
	<20040828200659.GS5492@holomorphy.com>
	<20040828200841.GT5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
>  +{
>  +	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
>  +	if (waitqueue_active(wq))
>  +		__wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
>  +}

The waitqueue_active() test needs a preceding barrier.  Did it
come from somewhere else, implicitly?
