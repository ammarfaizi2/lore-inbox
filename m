Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVEMX5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVEMX5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVEMX5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:57:33 -0400
Received: from mail.ccur.com ([208.248.32.212]:55354 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262456AbVEMX5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:57:23 -0400
Subject: Re: NFS: msync required for data writes to server?
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1115956128.12175.11.camel@lade.trondhjem.org>
References: <1115925686.6319.3.camel@lindad>
	 <20050512175720.74ea6a3e.akpm@osdl.org> <1115950903.6319.25.camel@lindad>
	 <20050512194210.10a9dc93.akpm@osdl.org>
	 <1115956128.12175.11.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1116028642.7846.12.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 13 May 2005 19:57:22 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2005 23:57:22.0702 (UTC) FILETIME=[81517AE0:01C55817]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond & Andrew,

Thank you both so much for your help!

The change fixed the problem we were having with the testsuite with mmap
of NFS files. We had 3 successful test runs today with the fix in place.
I found the changeset entry for this fix:

ChangeSet@1.2181.9.9, 2005-03-15 19:44:28-08:00, trond.myklebust@fys.uio.no
  [PATCH] NFS: Ensure that dirty pages are written with the right creds.
                                                                                 
   When doing shared mmap writes, the resulting dirty NFS pages may
   find themselves incapable of being flushed out if I/O is started
   after the file was released.

   Make sure we start I/O on all existing dirty pages in nfs_file_release().                                                                                 
   
Cheers!
Linda

