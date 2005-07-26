Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVGZTPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVGZTPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGZTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:15:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVGZTN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:13:56 -0400
Date: Tue, 26 Jul 2005 12:12:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726121250.0ba7d744.akpm@osdl.org>
In-Reply-To: <20050726114824.136d3dad.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	<20050726114824.136d3dad.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Can you please reduce the number of filesystems, see if that reduces the
>  dirty levels?

Also, it's conceivable that ext3 is implicated here, so it might be saner
to perform initial investigation on ext2.

(when kjournald writes back a page via its buffers, the page remains
"dirty" as far as the VFS is concerned.  Later, someone tries to do a
writepage() on it and we'll discover the buffers' cleanness and the page
will be cleaned without any I/O being performed.  All the throttling
_should_ work OK in this case.  But ext2 is more straightforward.)
