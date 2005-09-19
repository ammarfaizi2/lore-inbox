Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbVISV2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbVISV2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbVISV2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:28:42 -0400
Received: from pat.uio.no ([129.240.130.16]:22713 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932701AbVISV2l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:28:41 -0400
Subject: Re: ctime set by truncate even if NOCMTIME requested
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <432F2684.4040300@austin.rr.com>
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 19 Sep 2005 17:28:31 -0400
Message-Id: <1127165311.8519.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.091, required 12,
	autolearn=disabled, AWL 0.91, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 19.09.2005 Klokka 15:58 (-0500) skreiv Steve French:
> Trond Myklebust wrote:
> 
> >It is quite correct for the kernel to request that the filesystem set
> >ctime/mtime on successful calls to open(O_TRUNC).
> >  http://www.opengroup.org/onlinepubs/009695399/toc.htm
> >  
> >
> I agree that it is correct to set ctime/mtime here, just not convinced 
> it it worth setting it twice which is what will happen for non-local fs.
> 
> client truncate -> client setattr(for both size and ctime) -> server 
> setattr (which will have a sideffect of ctime to be set on the server, 
> not just the change to file size) and then another call to the server to 
> set the ctime (which will end up setting ctime twice - one to the 
> (correct) server's time and once to the less correct client's time.

If the VFS sets ATTR_[ACM]TIME, you should always assume that you are
being requested to set the [acm]time to server time. Doesn't CIFS allow
you that option?

Cheers,
  Trond

