Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUFUSrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUFUSrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUFUSrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:47:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:17368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264305AbUFUSrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:47:05 -0400
Date: Mon, 21 Jun 2004 11:46:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: da-x@colinux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-Id: <20040621114605.4df2c05e.akpm@osdl.org>
In-Reply-To: <40D6F986.3010904@microgate.com>
References: <20040621063845.GA6379@callisto.yi.org>
	<20040620235824.5407bc4c.akpm@osdl.org>
	<20040621073644.GA10781@callisto.yi.org>
	<20040621003944.48f4b4be.akpm@osdl.org>
	<20040621082430.GA11566@callisto.yi.org>
	<40D6F986.3010904@microgate.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> 13 other drivers call ldisc.chars_in_buffer without checking
>  for ldisc.chars_in_buffer == NULL, but only inside conditional
>  compilation for debug output. The value is not used, only logged.
>  These conditional debug items look like cut and paste from
>  one serial driver to another, and I doubt
>  they have been recently used (or used at all).
> 
>  Which would be better?
>  1. Ignore this
>  2. Fix conditional debug output to check
>      for ldisc.chars_in_buffer==NULL
>  3. Remove conditional debug output

Option 1 is quite valid.  There are no bugs here, yes?

If someone for some reason wants to clean all this up, the best way would
be to require that ->chars_in_buffer always be valid, hence remove all
those checks.

