Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUIQKdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUIQKdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUIQKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:33:15 -0400
Received: from sd291.sivit.org ([194.146.225.122]:46809 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268660AbUIQKcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:32:09 -0400
Date: Fri, 17 Sep 2004 12:32:07 +0200
From: Stelian Pop <stelian@popies.net>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917103207.GF21917@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <260353727@toto.iv> <16714.14118.212946.499226@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16714.14118.212946.499226@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:00:22AM +1000, Peter Chubb wrote:

> Andrew> All the struct needs is `head', `tail' and
> Andrew> `number_of_bytes_at_buf', all unsigned.
> 
> Andrew> add(char c) {
> Andrew>       p-> buf[p->head++ % p->number_of_bytes_at_buf] = c;
> Andrew> }
> 
> This depends on how expensive % is.  On IA64, something like this:
> 
>      add(char c) {
> 	     int i = p->head == p->len ? p->head++ : 0;
> 	     p->buf[i] = c;
>      }
> 
> is cheaper, as % generates a subroutine call to __modsi3.  It also is
> shorter =-- 12 bundles as opposed to 15.

Yup, but this is when doing char-by-char operations.

When using one or two memcpy() we have only two '%' intead of 
(perhaps) many 'if's.

Of course the memcpy() has its own while() loop but since it's 
optimized in assembly (and I guess we're not going to implement
kfifo_get/put in assembly) I will stay with the memcpy + '%' version.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
