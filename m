Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUKHVt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUKHVt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKHVt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:49:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:8413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261254AbUKHVs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:48:28 -0500
Date: Mon, 8 Nov 2004 13:52:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org, hunold@linuxtv.org
Subject: Re: [patch 1/6] v4l: yet another video-buf interface update
Message-Id: <20041108135222.5edde9f9.akpm@osdl.org>
In-Reply-To: <20041108085116.GA19146@bytesex>
References: <20041108085116.GA19146@bytesex>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
> This is one more interface fix for the video-buf.c module, the first
> attempt on that wasn't that clever.  Instead of passing the driver
> private data through all function calls I've just made that an element
> of the videobuf_queue struct which is passed around everythere _anyway_.

This patch throws a reject in videobuf_vm_close() because it's expecting

	map->q->ops->buf_release(vma->vm_file,map->q->bufs[i]);
and not
	map->q->ops->buf_release(vma->vm_file->private_data,map->q->bufs[i]);

I'll fix things up, but please check that.
