Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVF0W7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVF0W7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVF0W5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:57:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262046AbVF0W42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:56:28 -0400
Date: Mon, 27 Jun 2005 15:54:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [DVB patch 21/51] ttusb-dec: kfree cleanup
Message-Id: <20050627155403.70e2d77d.akpm@osdl.org>
In-Reply-To: <20050627121413.689826000@abc>
References: <20050627120600.739151000@abc>
	<20050627121413.689826000@abc>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
> From: Adrian Bunk <bunk@stusta.de>
> 
> The Coverity checker discovered that these two kfree's can never be
> executed.
> 

That's a bit strange - the code was OK beforehand.  It's a bit of a tossup.

>  
>  	/* allocate memory for the internal state */
>  	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);

This typecast is unneeded btw.  We tend to avoid casts to and from void*
because they defeat typechecking and uglify things.


