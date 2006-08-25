Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWHYVvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWHYVvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWHYVvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:51:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63453 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751509AbWHYVvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:51:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824182044.GE17658@us.ibm.com> 
References: <20060824182044.GE17658@us.ibm.com>  <20060824181722.GA17658@us.ibm.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 22:51:17 +0100
Message-ID: <22796.1156542677@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> filldir()'s inode number is now type u64 instead of ino_t.

Btw, in ecryptfs_interpose(), you have:

	inode = iget(sb, lower_inode->i_ino);

But you have to be *very* *very* careful doing that.  i_ino may be ambiguous.
My suggestions to make i_ino bigger were turned down by Al Viro; and even it
were bigger, it might still not be unique.

David
