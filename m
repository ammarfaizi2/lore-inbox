Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUEQKrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUEQKrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 06:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUEQKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 06:47:36 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:24068 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264962AbUEQKre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 06:47:34 -0400
Date: Mon, 17 May 2004 12:47:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: tglx@linutronix.de (Thomas Gleixner)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.26] drivers/char/vt.c fix compiler warnings
Message-ID: <20040517104729.GA8933@wsdw14.win.tue.nl>
References: <200405151505.23250.tglx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151505.23250.tglx@linutronix.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : mailhost.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4~On Sat, May 15, 2004 at 03:05:23PM +0200, Thomas Gleixner wrote:

> The patch fixes the following warnings, produced by gcc3.3.3:
> 
> s is a unsigned char, which can never be >= MAX_NR_KEYMAPS, as MAX_NR_KEYMAPS 
> = 256

> -	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> +	if (i >= NR_KEYS)
>  		return -EINVAL;	

You see that you break thew source in order to avoid a compiler warning. Bad.

(MAX_NR_KEYMAPS is a #define, often 256, on tiny systems people tend to pick 16.
The above test is not superfluous. MAX_NR_KEYMAPS is not an absolute constant.)

Andries
