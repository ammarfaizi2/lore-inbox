Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWKBRC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWKBRC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWKBRC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:02:28 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:3290 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751026AbWKBRC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:02:27 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] splice : Must fully check for fifos
Date: Thu, 2 Nov 2006 18:02:27 +0100
User-Agent: KMail/1.9.5
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>, tytso@mit.edu
References: <1162199005.24143.169.camel@taijtu> <45471A05.20205@yahoo.com.au> <200610311151.33104.dada1@cosmosbay.com>
In-Reply-To: <200610311151.33104.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021802.28519.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

I think this patch is necessary. It's quite easy to crash a 2.6.19-rc4 box :(

AFAIK the problem come from inode-diet (by Theodore Ts'o, (2006/Sep/27))

Thank you

[PATCH] splice : Must fully check for FIFO

It appears that i_pipe, i_cdev and i_bdev share the same memory location 
(anonymous union in struct inode) since commits 
577c4eb09d1034d0739e3135fd2cff50588024be
eaf796e7ef6014f208c409b2b14fddcfaafe7e3a

Because of that, testing i_pipe being NULL is not anymore sufficient to tell 
if an inode is a FIFO or not.

Therefore, we must use the S_ISFIFO(inode->i_mode) test before assuming i_pipe 
pointer is pointing to a struct pipe_inode_info.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

