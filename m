Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUIQQ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUIQQ04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUIQQYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:24:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38886 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269008AbUIQQOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:14:20 -0400
Date: Fri, 17 Sep 2004 17:14:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stelian Pop <stelian@popies.net>
cc: James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@novell.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040917154834.GA3180@crusoe.alcove-fr>
Message-ID: <Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Stelian Pop wrote:
> + * The size will be rounded-up to a power of 2.

> +	l = min(len, fifo->size - (fifo->in % fifo->size));
> +	memcpy(fifo->buffer + (fifo->in % fifo->size), buffer, l);

> +	l = min(len, fifo->size - (fifo->out % fifo->size));
> +	memcpy(buffer, fifo->buffer + (fifo->out % fifo->size), l);

The moduli can now be replaced by faster masks "& (fifo->size - 1)".

Hugh

