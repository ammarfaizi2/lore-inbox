Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUKHXVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUKHXVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKHXVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:21:00 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17123 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261297AbUKHXUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:20:52 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 9 Nov 2004 00:00:40 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hunold@linuxtv.org
Subject: Re: [patch 1/6] v4l: yet another video-buf interface update
Message-ID: <20041108230040.GA5312@bytesex>
References: <20041108085116.GA19146@bytesex> <20041108135222.5edde9f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108135222.5edde9f9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 01:52:22PM -0800, Andrew Morton wrote:
> Gerd Knorr <kraxel@bytesex.org> wrote:
> >
> > This is one more interface fix for the video-buf.c module, the first
> > attempt on that wasn't that clever.  Instead of passing the driver
> > private data through all function calls I've just made that an element
> > of the videobuf_queue struct which is passed around everythere _anyway_.
> 
> This patch throws a reject in videobuf_vm_close() because it's expecting
> 
> 	map->q->ops->buf_release(vma->vm_file,map->q->bufs[i]);
> and not
> 	map->q->ops->buf_release(vma->vm_file->private_data,map->q->bufs[i]);
> 
> I'll fix things up, but please check that.

Someone (Peter Osterlund IIRC) mailed a patch with the "vma->vm_file" =>
"vma->vm_file->private_data" fix to lkml.  Thats actually the place I
forgot on the first attempt and which causes the tvtime crashes
mentioned in the changelog.

My patches are built against a fresh linus bk tree, not against -mm, so
its probably just that patch being merged into -mm which causes the
rejects.  No problem, my patch obsoletes this one-liner fix.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
