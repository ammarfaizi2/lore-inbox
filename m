Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVLGQKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVLGQKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVLGQKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:10:09 -0500
Received: from pat.uio.no ([129.240.130.16]:55450 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751156AbVLGQKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:10:07 -0500
Subject: Re: another nfs puzzle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4397063A.2030200@redhat.com>
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
	 <4396EB2F.3060404@redhat.com>
	 <1133964667.27373.13.camel@lade.trondhjem.org> <4396EF50.30201@redhat.com>
	 <1133966063.27373.29.camel@lade.trondhjem.org>
	 <4397011E.9010703@redhat.com>
	 <1133970117.27373.53.camel@lade.trondhjem.org>
	 <4397063A.2030200@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 11:09:40 -0500
Message-Id: <1133971780.27373.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.744, required 12,
	autolearn=disabled, AWL 0.56, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 10:56 -0500, Peter Staubach wrote:

> I do know of other operating systems which do implement the semantics that I
> have suggested and I don't think that they are concerned or have been 
> notified
> that these semantics for a problem.  These semantics are used because the
> kernel itself can not even guarantee that the data that it is caching is 
> valid,
> without lots of synchronization which may tend to reduce performance.

I agree. It is clearly going to be a drag on performance, but it should
be very much a corner case, so...

To tell you the truth, I'm more interested in this case in order to
figure out how to make mmap() work correctly for the case of an ordinary
file, but where the file changes on the server. Currently we just call
invalidate_inode_pages2(), without unmapping first. The conclusion from
Kenny's testcase appears to be that this may lead to mmapped dirty data
being lost.

Cheers,
  Trond

