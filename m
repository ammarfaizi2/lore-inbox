Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVFGIxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVFGIxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 04:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVFGIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 04:53:23 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:23055 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261810AbVFGIxU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 04:53:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pxjx2yj/Y9bBWX/G1SgKYZiimSrkpInW2bSmpekgcIFdiKQqvqJABYX5qH4CG2b7yDII++oayUECkNboE7T7/3yHKpMpohPD/ifhwk83W9IjwTqGgsCE2lKZSmPcOMBjwuQ0qjvERyT2TceLI6kSceKSIVzJJc+oxqSFrmXJrNY=
Message-ID: <a36005b505060701531a545ba4@mail.gmail.com>
Date: Tue, 7 Jun 2005 01:53:19 -0700
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Subject: Re: Zeroed pages returned for heap
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <Pine.LNX.4.44.0506070936530.4569-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0506070936530.4569-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/05, Nagendra Singh Tomar <nagendra_tomar@adaptec.com> wrote:
> Is it OK for an application (a C library implementing malloc/calloc is
> also an application) to assume that the pages returned by the OS for heap
> allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will
> be zero filled.

The malloc code is glibc is defined with the assumption that brk
clears memory.  Since this is what the kernel implements it would be a
horrible waste of time to reinitialize the memory.  This behavior is
part of the kernel ABI and cannot be changed without breaking existing
applications without producing new libc DSOs (set MORECORE_CLEARS
appropriately) and relinking all statically linked apps.
