Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTEEUqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTEEUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:46:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53944 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261350AbTEEUqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:46:39 -0400
Date: Mon, 5 May 2003 16:58:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305052058.h45Kwd800522@devserv.devel.redhat.com>
To: "Lee, Shuyu" <SLee@cognex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to DMA data from a pci device to a user buffer directly
In-Reply-To: <mailman.1052164262.6444.linux-kernel2news@redhat.com>
References: <mailman.1052164262.6444.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 5) My DMA controller has unlimited scatter-gather capability.

> By the way, I have tested the rest of my code by DMA the image data to a
> kernel buffer allocated using kmalloc() first, then do a memcpy() to copy
> the image data to a user buffer. This alternative seems to work fine.

Use mmap to make the kmalloc-ed buffer available to user
application without the overhead of memcpy().

It is very wonderful that you can do s/g, so on the next stage
you can kmalloc a bunch of blocks with small order (1) and use
those instead of relying on bootmem allocation and Pauline's
bigphysarea patch. Most older controllers cannot do it.

-- Pete
