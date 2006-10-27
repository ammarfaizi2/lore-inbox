Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752467AbWJ0VTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbWJ0VTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbWJ0VTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:19:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752467AbWJ0VTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:19:50 -0400
Date: Fri, 27 Oct 2006 14:19:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@openedhand.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
Message-Id: <20061027141944.d68fef87.akpm@osdl.org>
In-Reply-To: <1161935995.5019.46.camel@localhost.localdomain>
References: <1161935995.5019.46.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 08:59:55 +0100
Richard Purdie <rpurdie@openedhand.com> wrote:

> Fix handling of write failures to swap devices.
> 
> Calling SetPageError(page) marks the data in memory as bad and processes using
> the page in question will die unexpectedly. This isn't necessary as the data 
> in the memory page is still valid, just the copy on disk isn't. This patch 
> therefore removes this call.
> 
> Setting set_page_dirty(page) is good as the memory page will be retained and 
> processes don't die. It will try to write out the page again soon but a second 
> attempt at a write is probably no more likely to succeed than the first 
> resulting in IO loops. We can do better.
> 
> This patch attempts to unuse the page in a similar manner to swapoff. If 
> successful, mark the swap page as bad and remove it from use. If we fail to
> remove all references, we fall back on set_page_dirty above which will retry 
> the write.
> 
> If we can mark the swap page as bad, adjust the VM accounting to reflect this.
> 

Sounds like a reasonable approach.  Please copy Hugh (our lead swapoff maintainer)
on this work.

How was this tested?
