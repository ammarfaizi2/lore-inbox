Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVITBhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVITBhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 21:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVITBhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 21:37:04 -0400
Received: from pat.uio.no ([129.240.130.16]:6305 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964824AbVITBhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 21:37:01 -0400
Subject: Re: ctime set by truncate even if NOCMTIME requested
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <432F5968.1020106@austin.rr.com>
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
	 <1127165311.8519.39.camel@lade.trondhjem.org>
	 <432F5968.1020106@austin.rr.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 19 Sep 2005 21:36:39 -0400
Message-Id: <1127180199.26459.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.639, required 12,
	autolearn=disabled, AWL 2.17, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 19.09.2005 Klokka 19:35 (-0500) skreiv Steve French:
  
> CIFS time format is similar to "DCE time" ie expressed as 100
> nanoseconds units since 1600 UTC.  In many large networks cifs clients
> in a domain will share an ntp or equivalent time source with the
> servers in the domain and will agree reasonably closely on what the
> UTC time is.  Ideally (at least from a performance perspective) most
> time stamps would be set implicitly by the server rather than
> explicitly by the client (in particular time of file creation, which
> is set by the server when the file is created, and last write time,
> set by the server after every write).  truncate of course is another
> example where time could be set implicitly by the server rather than
> explicitly by the client, but is hard to distinguish from explicit
> setattr.

That sucks... Even if the clients are synchronised using ntp, there is
no guarantee that two almost-simultaneous setattr RPC calls can't race
and cause time to go backwards if they have to explicitly set to the
"current" client time.

However if you know the cases where time is set implicitly by the
server, why can't you simply optimise away the ATTR_CTIME and/or
ATTR_MTIME?

Cheers,
  Trond

