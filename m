Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUITR6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUITR6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUITR6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:58:54 -0400
Received: from mail1.smlink.com ([212.143.64.225]:36692 "EHLO
	smmail.server.smlink.com") by vger.kernel.org with ESMTP
	id S266888AbUITR6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:58:52 -0400
Date: Mon, 20 Sep 2004 21:01:34 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040920210134.0b4af72c@sashak.lan>
In-Reply-To: <20040920151425.GA3020@crusoe.alcove-fr>
References: <20040917154834.GA3180@crusoe.alcove-fr>
	<Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
	<20040917205011.GA3049@crusoe.dsnet>
	<20040917212847.GC15426@dualathlon.random>
	<20040920151425.GA3020@crusoe.alcove-fr>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2004 18:58:43.0829 (UTC) FILETIME=[D9C33250:01C49F43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 17:14:26 +0200
Stelian Pop <stelian@popies.net> wrote:

> +unsigned int __kfifo_get(struct kfifo *fifo, 
> +			 unsigned char *buffer, unsigned int len)
> +{
> +	unsigned int l;
> +
> +	len = min(len, fifo->in - fifo->out);
> +
> +	/* first get the data from fifo->out until the end of the buffer */
> +	l = min(len, fifo->size - (fifo->out & (fifo->size - 1)));
> +	memcpy(buffer, fifo->buffer + (fifo->out & (fifo->size - 1)), l);
> +
> +	/* then get the rest (if any) from the beginning of the buffer */
> +	memcpy(buffer, fifo->buffer + l, len - l);

I guess last line should be:

  memcpy(buffer + l, fifo->buffer, len - i)

Sasha.
