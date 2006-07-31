Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWGaSYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWGaSYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWGaSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:24:22 -0400
Received: from pat.uio.no ([129.240.10.4]:2775 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030307AbWGaSYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:24:21 -0400
Subject: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chuck Ebbert <76306.1226@compuserve.com>, sfr@canb.auug.org.au,
       "William A (Andy) Adamson" <andros@citi.umich.edu>
Cc: Orion Poplawski <orion@cora.nwra.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200607310224_MC3-1-C689-D6DD@compuserve.com>
References: <200607310224_MC3-1-C689-D6DD@compuserve.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 11:23:52 -0700
Message-Id: <1154370233.8417.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.622, required 12,
	autolearn=disabled, AWL 1.38, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 02:21 -0400, Chuck Ebbert wrote:

> static void lease_release_private_callback(struct file_lock *fl)
> {
>         if (!fl->fl_file)
>                 return;
> 
>         f_delown(fl->fl_file);
> =>      fl->fl_file->f_owner.signum = 0;
> }

Why should the lease cleanup code be resetting f_owner.signum? That
looks wrong.

Stephen, I think this line of code predates the CITI changes. Do you
know who added it and why?

Cheers,
  Trond

