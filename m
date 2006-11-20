Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934252AbWKTQce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252AbWKTQce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934256AbWKTQce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:32:34 -0500
Received: from pat.uio.no ([129.240.10.15]:937 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S934252AbWKTQcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:32:33 -0500
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 11:32:06 -0500
Message-Id: <1164040326.5700.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.206, required 12,
	autolearn=disabled, AWL 1.66, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 14:27 +0000, David Howells wrote:
> 
> The workqueue struct is huge, and this limits it's usefulness.  On a 64-bit
> architecture it's nearly 100 bytes in size, of which the timer_list is half.
> These patches shrink work_struct by 8 of the 12 words it ordinarily consumes.
> This is done by:
> 
>  (1) Splitting the timer out so that delayable work items are defined by a
>      separate structure which incorporates a basic work_struct and a timer.

Why not simply add a timer argument to 'queue_delayed_work()' and
'cancel_delayed_work()'? That may allow you to reuse an existing timer
struct if you already have it embedded somewhere else.

Cheers
  Trond

