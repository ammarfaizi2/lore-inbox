Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVF0JkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVF0JkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVF0JkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:40:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261660AbVF0JkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:40:00 -0400
Date: Mon, 27 Jun 2005 10:39:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zuzana Petrova <zpetrova@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs:lock_rename()/unlock_rename() can lead to deadlock in distributed fs.
Message-ID: <20050627093959.GA5470@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zuzana Petrova <zpetrova@suse.cz>, linux-kernel@vger.kernel.org
References: <20050627092448.GA8822@lilac.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627092448.GA8822@lilac.suse.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 11:24:49AM +0200, Zuzana Petrova wrote:
> When lock_rename(new_dir, old_dir) is called, the dentries don't match, so we  
> end up in a code path that tries to acquire the inode i_sem of both the  
> old_dir and new_dir, but since they point to the same inode, the second  
> attempt to acquire the same i_sem results in a deadlock.  
>   
> A fix would be to compare the dentries ->d_inode field instead.  Patch for  
> kernel 2.6.12.1 attached.

No, that's bogus.  Make sure the filesystem never has multiple dentries
for the same directory inode.  
