Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUION2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUION2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUION2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:28:06 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:57498 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266149AbUION17 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:27:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Wed, 15 Sep 2004 08:27:54 -0500
User-Agent: KMail/1.6.2
References: <20040913135253.GA3118@crusoe.alcove-fr>
In-Reply-To: <20040913135253.GA3118@crusoe.alcove-fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409150827.55011.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 08:52 am, Stelian Pop wrote:
> +static inline unsigned int kfifo_len(struct kfifo *fifo) {
> +       unsigned long flags;
> +       unsigned int result;
> +       
> +       spin_lock_irqsave(&fifo->lock, flags);
> +       
> +       result = fifo->len;
> +
> +       spin_unlock_irqrestore(&fifo->lock, flags);
> +
> +       return result;
> +}

Hi,

I do not think that taking/releasing spinlock here serves any purpose as
len can get canged right after releasing the lock and therefore no longer
valid... And relying on result of kfifo_len to decide if the FIF can be
drained is not reliable so probably the inteface is better off without this
function.

Also I think that most users would put only sertain structures (homogenous?)
in their FIFOs so maybe it should be:

struct kfifo *kfifo_alloc(unsigned int el_size, unsigned int len)
unsigned int kfifo_put(struct kfifo *fifo, void *buffer)
unsigned int kfifo_get(struct kfifo *fifo, void *buffer)

Also, don't we have a rule that for functions the opening curly brace should
be on a new line?

-- 
Dmitry
