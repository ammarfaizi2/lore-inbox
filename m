Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVAGWqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVAGWqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVAGWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:43:49 -0500
Received: from pat.uio.no ([129.240.130.16]:21694 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261679AbVAGWlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:41:00 -0500
Subject: Re: [RFC] 2.4 and stack reduction patches
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
	 <20050107141224.GF29176@logos.cnet>
	 <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 17:40:46 -0500
Message-Id: <1105137646.10979.155.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.01.2005 Klokka 13:42 (-0800) skreiv Badari Pulavarty:

> Here are the changes and savings.
> 
> do_execve                    320
> number                       100
> nfs_lookup                   184
> nfs_cached_lookup             88
> __revalidate_inode           112
> rpc_call_sync                144
> xprt_sendmsg                 120

There is no nfs_cached_lookup() in the mainline 2.4 tree. That is part
of the READDIRPLUS code, and was therefore never merged.

You're better off using rpc_new_task() in rpc_call_sync(): no kfree()
required, and no rpc_init_task() required.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

