Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWCBBtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWCBBtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCBBtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:49:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751359AbWCBBti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:49:38 -0500
Date: Wed, 1 Mar 2006 17:51:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] change buffer_head.b_size to size_t
Message-Id: <20060301175148.2250b36e.akpm@osdl.org>
In-Reply-To: <1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> + * Historically, a buffer_head was used to map a single block
> + * within a page, and of course as the unit of I/O through the
> + * filesystem and block layers.  Nowadays the basic I/O unit
> + * is the bio, and buffer_heads are used for extracting block
> + * mappings (via a get_block_t call), for tracking state within
> + * a page (via a page_mapping) and for wrapping bio submission
> + * for backward compatibility reasons (e.g. submit_bh).

Well kinda.  A buffer_head remains the kernel's basic abstraction for a
"disk block".  We cannot replace that with `struct page' (size isn't
flexible) nor of course with `struct bio'.

