Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUEQNgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUEQNgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 09:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUEQNgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 09:36:08 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30482 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261358AbUEQNgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 09:36:05 -0400
Date: Mon, 17 May 2004 15:36:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: tglx@linutronix.de (Thomas Gleixner)
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.26] drivers/char/vt.c fix compiler warnings
Message-ID: <20040517133603.GA10913@wsdw14.win.tue.nl>
References: <200405151505.23250.tglx@linutronix.de> <20040517104729.GA8933@wsdw14.win.tue.nl> <200405171447.56737.tglx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405171447.56737.tglx@linutronix.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 02:47:56PM +0200, Thomas Gleixner wrote:

> > (MAX_NR_KEYMAPS is a #define, often 256, on tiny systems people tend to
> > pick 16. The above test is not superfluous. MAX_NR_KEYMAPS is not an
> > absolute constant.)
> 
> Ooops, did not think about that. Was just annoyed from the compiler warnings.
> What about:
> 
>  	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
>  		return -EFAULT;
> +#if MAX_NR_KEYMAPS < 256		
>  	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> +#else
> +	if (i >= NR_KEYS)
> +#endif	

(i) My muttering was not just about this case - also elsewhere
you removed tests that are only superfluous under a particular
constellation of #define-s.
(ii) Introducing conditional compilation certainly would not
make anybody happier.

I don't have the code nearby, but probably you could use an (unsigned) integer
variable.

Andries
