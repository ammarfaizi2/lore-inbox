Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUCAHPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCAHPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 02:15:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34194 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262259AbUCAHPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 02:15:05 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Early memory patch, +accounting
References: <403ADCDD.8080206@zytor.com>
	<m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
	<403CEE33.3020601@zytor.com>
	<m1oerlevny.fsf_-_@ebiederm.dsl.xmission.com>
	<403E34B1.3030608@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2004 00:06:58 -0700
In-Reply-To: <403E34B1.3030608@zytor.com>
Message-ID: <m11xod9hbh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > I intend to export _end into setup.S so a bootloader can
> > tell what memory the kernel will attempt to use before looking at
> > the e820 map, the kernel command line, and the initrd location.
> > After that the kernel can properly dynamically allocate things.
> >
> 
> You're confusing "may" with "will".  This is the fundamental problem with this
> approach.

If the margin of error was significant I would agree.  The margin of error
in this case is very small.

> > Exporting _end will allow two things.
> > 1) On systems with a 15M-16M I/O hole the bootloader can check to see
> >    if a big kernel will attempt to use memory in that region.
> > 2) On small memory systems it will let the bootloader make a good
> >    estimate to see if everything will fit into memory.
> 
> No, it won't, because it still has no idea whatsoever how much dynamically
> allocated memory it needs during boot.

It will at least ensure the kernel can run long enough to fail gracefully.
I admit that a panic is not the most graceful failure but it does at least
let you know what went wrong.

Eric
