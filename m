Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWCHHQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWCHHQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWCHHQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:16:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932069AbWCHHQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:16:17 -0500
Date: Tue, 7 Mar 2006 23:14:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: yet more slab corruption.
Message-Id: <20060307231414.34c3b3a4.akpm@osdl.org>
In-Reply-To: <20060307235940.GA16843@redhat.com>
References: <20060307235940.GA16843@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> Garg. Is there no end to these ?
> That kernel is based off 2.6.16rc5-git8
> 
> This brings the current count up to 8 different patterns filed
> against our 2.6.16rc tree in Fedora bugzilla.
> (One of them doesn't count as it's against the out-of-tree bcm43xx driver).
> 

A use-after-free on size-2048.  We wrote -1L and 0L apparently 0x6b8 bytes
into the object.  That's an awfully large offset for tty_struct - off the
end.  Sometimes the buffer was used as skb data too.

Unless it was a DMA scribble, CONFIG_DEBUG_PAGEALLOC should catch this.
