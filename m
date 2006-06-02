Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWFBVGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWFBVGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWFBVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:06:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030265AbWFBVGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:06:05 -0400
Date: Fri, 2 Jun 2006 23:06:03 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060602210603.GA10395@suse.de>
References: <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org> <20060601214158.GA438@suse.de> <20060601145747.274df976.akpm@osdl.org> <20060602084327.GA3964@suse.de> <20060602021115.e42ad5dd.akpm@osdl.org> <20060602191430.GA9357@suse.de> <20060602124143.0898384f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060602124143.0898384f.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jun 02, Andrew Morton wrote:

> Oh, OK, we cannot use read_cache_page().  Because the above is still racy
> (and still needs the retry loop).  We need to set PG_checked before
> launching the read.  Something like:
> 
> /*
>  * Return a locked, uptodate, !PagePrivate, !PageChecked page which needs a
>  * single put_page by the caller.
>  */
> cramfs_read_getpage()
> {
> 	page = find_lock_page()
> 	if (PageUptodate(page))
> 		return page;
> 	SetPagePrivate()
> 	SetPageChecked()
> 	err = m->a_ops->readpage(page);

I guess we have to put a find_or_create_page in there, and fill it.
Will try that tomorrow.
