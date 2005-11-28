Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVK1RPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVK1RPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVK1RPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:15:31 -0500
Received: from pat.uio.no ([129.240.130.16]:25086 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932127AbVK1RPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:15:30 -0500
Subject: Re: inode_change_ok
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1133197587.27574.19.camel@lade.trondhjem.org>
References: <438B42F3.1040006@austin.rr.com>
	 <1133197587.27574.19.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 12:15:13 -0500
Message-Id: <1133198114.27574.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.95, required 12,
	autolearn=disabled, AWL 1.86, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 12:06 -0500, Trond Myklebust wrote:
> On Mon, 2005-11-28 at 11:48 -0600, Steve French wrote:
> > Why are there no calls to inode_change_ok in nfs (on the client), but 
> > there are in most other filesytsems?   Seems like there are some cases 
> > in nfs in which a local permission check is done via  a call to 
> > nfs_permission which calls generic_permission ... if that is the case 
> > why not do a call to inode_change_ok in similar cases?
> 
> Under the NFS model, the server manages the permissions, not the client.
> 
> The purpose of inode_change_ok() is to perform a load of local checks
> which are simply alien to that model: 
> 
>  a) your capabilities don't mean anything to the server. Its decision to
> grant the ability to change owner of a file is based on your
> credentials, not your capabilities.
> 
>  b) Even the uid/gid checks don't take into account the fact that the
> server may be mapping you into different users/groups (c.f. root
> squashing etc.).
> 
> All, in all, a call to inode_change_ok() would at best be redundant, and
> at worst, be plain incorrect.

BTW: The call to permission() is thoroughly redundant too, and really
wants to be optimised away. Permissions checking is done by the server
on the actual SETATTR RPC call...

Cheers,
  Trond

