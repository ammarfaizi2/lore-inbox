Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUHSLZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUHSLZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHSLYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:24:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:13959 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265668AbUHSLY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:24:28 -0400
Date: Thu, 19 Aug 2004 04:22:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, olof@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Alignment of bitmaps for ext2_set_bit et al.
Message-Id: <20040819042234.75020cbc.akpm@osdl.org>
In-Reply-To: <16676.35837.215958.814591@cargo.ozlabs.ibm.com>
References: <16676.35837.215958.814591@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> What can we assume about the alignment of the bitmap pointer passed to
> the ext2_{set,clear}_bit_atomic functions?  Can we assume that they
> will be aligned to an long boundary (8 bytes on 64-bit)?

For ext2 and ext3 it's safe to assume that they are 1024-byte aligned.

But it's possible that other filesystems are using these (awfully named)
functions.

Well.  I doubt if anyone is using the _atomic versions yet.

> Olof has made a patch that uses atomics for these on ppc64 rather than
> locking and unlocking a lock, but it will only work correctly if the
> bitmap is always 8-byte aligned.

Sounds sane, as long as you get firmly notified when a poorly-aligned
address is fed in.
