Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVFKRcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVFKRcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVFKRbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:31:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16259 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261764AbVFKRag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:30:36 -0400
Date: Sat, 11 Jun 2005 18:30:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Assuming NULL
Message-ID: <20050611173035.GA1847@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 06:24:22PM +0200, Jan Engelhardt wrote:
> Hi developers,
> 
> 
> 
> some places in fs/*.c have conditions like
> 
> (namei.c, 238, in "int permission()"):
>         if(inode->i_op && inode->i_op->permission)
> 
> Others just have
> (namei.c, 813, in "int fastcall link_path_walk()"):
>         if(!inode->i_op->lookup)
> 
> My question is: Which one is right wrt the case "i_op ==/!= NULL"?
> There are two ways:
> 
> - the kernel assumes i_op (and similar) is always non-NULL
>   => then we can remove a lot of checks, like the first example above

i_op must not be NULL .alloc_inode() intitializes it to &empty_iops,
and setting it to NULL would be a bug.

