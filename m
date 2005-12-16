Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVLPUhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVLPUhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVLPUhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:37:24 -0500
Received: from pat.uio.no ([129.240.130.16]:65187 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932388AbVLPUhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:37:23 -0500
Subject: Re: [PATCH 3/3] Fix problems on multi-TB filesystem and file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <2cd57c900512161224i1079572ao@mail.gmail.com>
References: <000201c60242$318eff70$4168010a@bsd.tnes.nec.co.jp>
	 <2cd57c900512161139n7d738415q@mail.gmail.com>
	 <1134763048.18635.3.camel@lade.trondhjem.org>
	 <2cd57c900512161224i1079572ao@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 15:37:11 -0500
Message-Id: <1134765431.7941.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.861, required 12,
	autolearn=disabled, AWL 1.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 04:24 +0800, Coywolf Qi Hunt wrote:

> >
> > It may surprise you to learn that not all network filesystems are block
> > based.
> >
> > NFS has no truck with CONFIG_LBD at all.
> 
> I thought no network filesystems are block based from a client
> viewpoint.  (There's a network block driver though.) Client kernel
> needn't enable LBD.

Without this patch, the client _would_ have to enable LBD if it wanted
to correctly report the size of a large disk on the remote server.

The main point, though is that sector_t is a handle to a block. It is
_NOT_ the right type to use for reporting a disk size.

Cheers,
  Trond

