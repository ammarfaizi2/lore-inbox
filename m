Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWACTqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWACTqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWACTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:46:31 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:22710 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932507AbWACTqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:46:30 -0500
Date: Tue, 3 Jan 2006 12:46:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Peter Staubach <staubach@redhat.com>
Cc: ASANO Masahiro <masano@tnes.nec.co.jp>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix posix lock on NFS
Message-ID: <20060103194630.GL19769@parisc-linux.org>
References: <20051222.132454.1025208517.masano@tnes.nec.co.jp> <43BAD2EC.2030807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BAD2EC.2030807@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 02:39:24PM -0500, Peter Staubach wrote:
> >	/* No mandatory locks over NFS */
> >-	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
> >+	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
> >+	    fl->fl_type != F_UNLCK)
> 
> Just out of curiosity, what is this if() statement intended to protect?
> For locking purposes, why would the client care if the file has the
> mandatory lock bits set?

Mandatory locks aren't mandatory for other clients.
