Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTL3CGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTL3CGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:06:20 -0500
Received: from dp.samba.org ([66.70.73.150]:33259 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264322AbTL3CGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:06:14 -0500
Date: Tue, 30 Dec 2003 13:00:29 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@osdl.org, mfedyk@matchmail.com, ebiederm@xmission.com,
       anton@mips.complang.tuwien.ac.at, linux-kernel@vger.kernel.org,
       phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-Id: <20031230130029.6183a872.rusty@rustcorp.com.au>
In-Reply-To: <20031229102319.GW22443@holomorphy.com>
References: <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
	<20031228163952.GQ22443@holomorphy.com>
	<20031229003631.GE1882@matchmail.com>
	<20031229025507.GT22443@holomorphy.com>
	<Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
	<20031229065240.GU22443@holomorphy.com>
	<Pine.LNX.4.58.0312290112450.11299@home.osdl.org>
	<20031229092203.GL27687@holomorphy.com>
	<Pine.LNX.4.58.0312290129510.11299@home.osdl.org>
	<20031229102319.GW22443@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 02:23:19 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> The fact merely elevating PAGE_SIZE breaks numerous things makes me
> rather suspicious of claims that minimalistic patches can do likewise.

Can you give an example?

	One approach is to simply present a larger page size to userspace w/
getpagesize().  This does break ELF programs which have been laid out assuming
the old page size (presumably they try to mprotect the read-only sections).
On PPC, the ELF ABI already insists on a 64k boundary between such sections,
and maybe for others you could simply round appropriately and pray, or do
fine-grained protections (ie. on real pagesize) for that one case.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
