Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVAIWoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVAIWoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVAIWoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:44:39 -0500
Received: from pat.uio.no ([129.240.130.16]:2746 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261913AbVAIWod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:44:33 -0500
Subject: Re: make flock_lock_file_wait static
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Arjan van de Ven <arjan@infradead.org>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050109194209.GA7588@infradead.org>
References: <20050109194209.GA7588@infradead.org>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 17:44:10 -0500
Message-Id: <1105310650.11315.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 09.01.2005 Klokka 19:42 (+0000) skreiv Arjan van de Ven:
> Hi,
> 
> the patch below makes flock_lock_file_wait static, because it is only used
> (once) in fs/locks.c. Making it static allows gcc to generate better code
> (partial or entirely inlining it, gcc 3.4 also optimizes the calling
> convention for static functions which are guaranteed only local to the file)

Veto. That function is also there for those filesystems that need to
mirror their locks in the VFS. I believe the GFS people are already
using it (they implemented all this anyway), and sooner or later, NFS is
going to have to do it too...

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

