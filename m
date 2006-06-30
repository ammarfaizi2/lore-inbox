Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWF3N7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWF3N7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWF3N7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:59:31 -0400
Received: from pat.uio.no ([129.240.10.4]:31654 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932631AbWF3N7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:59:30 -0400
Subject: Re: [RFC] [PATCH] do_sys_truncate: call do_truncate with
	ATTR_MTIME|ATTR_CTIME
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: lkml <Linux-Kernel@vger.kernel.org>
In-Reply-To: <1151674409.6499.52.camel@tribesman.namesys.com>
References: <1151674409.6499.52.camel@tribesman.namesys.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 09:59:15 -0400
Message-Id: <1151675955.2276.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.181, required 12,
	autolearn=disabled, AWL 1.63, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 17:33 +0400, Vladimir V. Saveliev wrote:
> Hello
> 
> do_sys_ftruncate calls do_truncate with time_attrs set to ATTR_MTIME|
> ATTR_CTIME. Is there a reason for do_sys_truncate to not set time_attrs
> to the same value or it is a bug?

It would be a bug.

In the case of truncate(), the filesystem has to decide if the file size
will actually change. If it does, then it has to update mtime/ctime. In
the case of ftruncate(), it would appear that the filesystem always has
to update mtime/ctime on success, so it is appropriate to call
do_truncate with ATTR_MTIME/ATTR_CTIME.

Cheers,
  Trond

> email message attachment (do_truncate-time_attrs.patch)
> > -------- Forwarded Message --------
> > Subject: No Subject
> > Date: Fri, 30 Jun 2006 17:33:29 +0400
> > 

