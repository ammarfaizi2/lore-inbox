Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTJDFrj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 01:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbTJDFrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 01:47:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:3219 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261831AbTJDFri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 01:47:38 -0400
Date: Fri, 3 Oct 2003 22:47:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20031003224727.2f6956b5.davem@redhat.com>
In-Reply-To: <20031003172727.3d2b6cb2.akpm@osdl.org>
References: <20031003214411.GA25802@rudolph.ccur.com>
	<20031003152349.7194b73d.akpm@osdl.org>
	<20031003225509.GA26590@rudolph.ccur.com>
	<20031003161540.42ff98bb.akpm@osdl.org>
	<20031003235416.GA27201@rudolph.ccur.com>
	<20031003172727.3d2b6cb2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003 17:27:27 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Maybe it's best to not overload VM_RESERVED in this manner, but to always
> mark /dev/mem as VM_IO. 

Just in cast is isn't clear, it should be defined that anything
that sets VM_IO on an mmap() area should prefill the page tables
as a side effect of such a mmap() request.

Then things like mlockall() have simple semantics on VM_IO area, they
end up being a nop.
