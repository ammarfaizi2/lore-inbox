Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUESHo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUESHo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUESHo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:44:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:36999 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264076AbUESHo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:44:57 -0400
Date: Wed, 19 May 2004 00:44:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: pte_addr_t size reduction for 64 GB case?
Message-Id: <20040519004424.72f5eb9e.akpm@osdl.org>
In-Reply-To: <1084941731.955.836.camel@cube>
References: <1084941731.955.836.camel@cube>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> When handling 64 GB on i386, pte_addr_t really only
> needs 33 bits to find the PTE. It sure doesn't need
> the full 64 bits it is using.

yup.

> How about cheating a bit? If the pte_addr_t only had
> the high 32 bits of the 36-bit pointer, it would point
> to a pair of the 8-byte PTEs in a 16-byte chunk of RAM.
> Then simply examine the PTEs to see which one is the
> correct one.

They might both map the same page.  It could overflow into page->flags.
