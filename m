Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVKVAJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVKVAJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKVAJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:09:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932394AbVKVAJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:09:26 -0500
Date: Mon, 21 Nov 2005 16:09:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
Message-Id: <20051121160913.6d59c9fa.akpm@osdl.org>
In-Reply-To: <1132617503.8011.35.camel@lade.trondhjem.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	<1132612974.8011.12.camel@lade.trondhjem.org>
	<20051121153454.1907d92a.akpm@osdl.org>
	<1132617503.8011.35.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> The only difference I can see between the two paths is the call to
>  unmap_mapping_range(). What effect would that have?

It shoots down any mapped pagecache over the affected file region.  Because
the direct-io write is about to make that pagecache out-of-date.  If the
application tries to use that data again it'll get a major fault and will
re-read the file contents.

