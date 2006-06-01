Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWFAFzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWFAFzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWFAFzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:55:53 -0400
Received: from pat.uio.no ([129.240.10.4]:47750 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751802AbWFAFzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:55:52 -0400
Subject: Re: Why must NFS access metadata in synchronous mode?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com>
References: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 01:55:40 -0400
Message-Id: <1149141341.13298.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.367, required 12,
	autolearn=disabled, AWL 1.45, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 00:04 -0400, Xin Zhao wrote:
> Until kernel 2.6.16, I think NFS still access metadata synchronously,
> which may impact performance significantly. Several years ago, paper
> "metadata update performance in file systems" already suggested using
> asynchronous mode in metadata access.

...and how many NFS implementations have you seen based on that paper?

> I am curious why NFS does not adopt this suggestion? Can someone explain this?

a) NFS permissions are checked by the _server_, not the client.

b) Cache consistency requirements are _much_ more stringent for
asynchronous operation. Think for instance about an asynchronous
mkdir(): how should the client guarantee exclusive semantics (i.e. that
mkdir either creates a new directory or returns an EEXIST error)? how
should it guarantee that the server will have enough disk space to
satisfy your request? how should it guarantee that nobody will change
the permissions on the parent directory before the metadata was synced
to disk?,...

People are considering how to implement this sort of thing using the
NFSv4 concept of delegations and applying them to directories. It is not
yet obvious how all the details will be solved.

Trond

