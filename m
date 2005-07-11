Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVGKXbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVGKXbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVGKX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:29:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262257AbVGKX1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:27:49 -0400
Date: Mon, 11 Jul 2005 16:28:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ll_rw_block() wait for buffer lock
Message-Id: <20050711162846.40304ab0.akpm@osdl.org>
In-Reply-To: <20050711155108.GR12428@atrey.karlin.mff.cuni.cz>
References: <20050711155108.GR12428@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>   attached patch adds an operation SWRITE to ll_rw_block(). When this
> operation is specified ll_rw_block() waits for a buffer lock and doesn't
> just skip the locked buffer. Under some circumstances we need to make
> sure that current data are really being sent to disk and the old
> ll_rw_block()'s behaviour makes this impossible to achieve (as in some
> places we lock and unlock buffer without sending it to disk).

Fair enough - it's certainly saner this way.

Ordinarily it would be nicer to add a new function for this, say

	ll_sync_write_bufs(struct buffer_head **bufs, int nr)

rather than adding new interpretations to ll_rw_block().

But ll_rw_block() is such a familiar old thing that I guess there's not
much advantage in adding some new thing for people to remember.
