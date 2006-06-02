Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWFBSpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWFBSpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFBSpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:45:07 -0400
Received: from pat.uio.no ([129.240.10.4]:36481 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932179AbWFBSpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:45:05 -0400
Subject: Re: Why NFS enforce size limit on readdirplus
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140606012254i5fa92953rdd1ea229be9a02f9@mail.gmail.com>
References: <4ae3c140606012254i5fa92953rdd1ea229be9a02f9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 14:44:55 -0400
Message-Id: <1149273895.5621.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.713, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 01:54 -0400, Xin Zhao wrote:
> Maybe this question is a little dumb.
> 
> I am wondering why in NFS readdirplus can be used only for directories
> of size less than 8*PAGE_SIZE, otherwise, it will switch to use normal
> readdir?
> 
> In nfs/inode.c, I noticed the following code:
> 			    if (nfs_server_capable(inode, NFS_CAP_READDIRPLUS) &&
> fattr->size <= NFS_LIMIT_READDIRPLUS)
> 				    set_bit(NFS_INO_ADVISE_RDPLUS, &NFS_FLAGS(inode));
> 
> Can someone kindly explain the reason?

Efficiency: READDIRPLUS requires a lookup for each entry. If there are
too many entries, the whole thing gets really really slow...

Cheers,
  Trond

