Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUFTQYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUFTQYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbUFTQYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:24:13 -0400
Received: from havoc.gtf.org ([216.162.42.101]:14025 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264502AbUFTQYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:24:12 -0400
Date: Sun, 20 Jun 2004 12:24:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: Nick Bartos <spam99@2thebatcave.com>, linux-kernel@vger.kernel.org
Subject: Re: Using kernel headers that are not for the running kernel
Message-ID: <20040620162405.GA16038@havoc.gtf.org>
References: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12> <200406190546.50166.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406190546.50166.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 05:46:50AM -0500, Rob Landley wrote:
> The linux-kernel maintainers apparently decided that C libraries using kernel 
> headers to actually interface with the kernel was a bad idea.  Apparently, 
> interfacing with the kernel from a C library is not a proper use for kernel 
> headers, or something.  (I tried to follow the logic in this discussion, but 
> never actually found any, despite repeated attempts.  It always seemed to 
> boil down to "can't be bothered", "userspace shouldn't use kernel headers and 
> this includes the C library", etc...)

No, the problem is that the only thing that needs to be shared are the
_ABI_ headers, which are unfortunately mixed in with kernel-internal
headers and definitions.  This leads to use of kernel-internal
definitions in userspace, which leads to breakage.  This also leads to
restrictions on changing -kernel-internal- headers, because some
userspace wanker is complaining.

Kernel-internal headers and definitions should absolutely never be used
in userspace.

H. Peter Anvin has suggested an include/abi which could be shared, and
this seem quite reasonable to me.  However, the monumental task of
separating kernel-internal definitions from ABI definitions still
remains.

	Jeff, really glad the linux-libc-headers guys started his effort



