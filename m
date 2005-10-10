Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVJJPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVJJPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVJJPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:06:58 -0400
Received: from silver.veritas.com ([143.127.12.111]:9516 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750737AbVJJPG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:06:58 -0400
Date: Mon, 10 Oct 2005 16:06:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]should swap-file opened with O_DIRECT?
In-Reply-To: <20051010135229.D29B5FB048@gatekeeper.ncic.ac.cn>
Message-ID: <Pine.LNX.4.61.0510101558140.1168@goblin.wat.veritas.com>
References: <20051010135229.D29B5FB048@gatekeeper.ncic.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Oct 2005 15:06:51.0330 (UTC) FILETIME=[3E4E1220:01C5CDAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Yingchao Zhou wrote:
> 
>   The sys_swapon system call open the swap-file through 
> filp_open(..., O_RDWR|O_LARGEFILE,...).
>   In this way, I think that the pageout process of anonymous
> pages finally will write them out through (swap-file)->f_ops->write,

No, they are written out by swap_writepage.   The opening in sys_swapon
gets a handle of what is to be used for swap, but it then goes its own way.

> and it will result in caches of swapfile. However, swapping only 
> happens when memory is tight. So why not set O_DIRECT? Is there any
> special reason to keep caches of swapfile?

Caches of swapfile are useful (but yes, can be discarded when memory
is tight).  There's nothing indirect about them: the page that is mapped
into userspace gets written to disk, the page that is read in from disk
gets mapped back into userspace.

Hugh
