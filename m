Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWDUXWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDUXWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDUXWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:22:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWDUXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:22:46 -0400
Date: Fri, 21 Apr 2006 16:25:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Hua Zhong" <hzhong@gmail.com>
Cc: jmorris@namei.org, dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421162501.0fd7a34b.akpm@osdl.org>
In-Reply-To: <000e01c66596$66961750$853d010a@nuitysystems.com>
References: <20060421144233.1201cf07.akpm@osdl.org>
	<000e01c66596$66961750$853d010a@nuitysystems.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hua Zhong" <hzhong@gmail.com> wrote:
>
> > struct likeliness {
> > 	char *file;
> > 	int line;
> > 	atomic_t true_count;
> > 	atomic_t false_count;
> > 	struct likeliness *next;
> > };
> 
> It seems including atomic.h inside compiler.h is a bit tricky (might have interdependency).
> 
> Can we just live with int instead of atomic_t? We don't really care about losing a count occasionally..

Sure, int or long would work OK.

> > It'll crash if a module gets registered then unloaded. 
> > CONFIG_MODULE_UNLOAD=n would be required.
> 
> What about init data that is thrown away after boot?

Good point.  Putting #ifndef CONFIG_foo around init/main.c:init()'s call to
free_initmem would fix that.
