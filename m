Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTFKHrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 03:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTFKHrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 03:47:35 -0400
Received: from ns.suse.de ([213.95.15.193]:29456 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264202AbTFKHre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 03:47:34 -0400
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
References: <3EE6B7A2.3000606@austin.rr.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jun 2003 10:01:00 +0200
In-Reply-To: <3EE6B7A2.3000606@austin.rr.com.suse.lists.linux.kernel>
Message-ID: <p73he6x59hf.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> writes:

> look wrong for gcc to spit out warnings on.   For example the following
> local variable definition and the similar ones in the same file
> (fs/cifs/inode.c):
> 
> 	__u64 uid = 0xFFFFFFFFFFFFFFFF;
> 
> generates a warning saying the value is too long for a long on x86
> SuSE 8.2 with gcc 3.3 - which makes no sense.  Any value
> above 0xFFFFFFFFF generates the same warning (intuitively
> 36 bits should fit in an unsigned 64 bit local variable).
> 
> Defining the literal with the UL suffix didn't seem to help - and I

Define it with ULL   (= long long) 

> Any idea what is going on in this weird gcc 3.3 behavior where it thinks
> 64 bits can't fit in a __u64 local variable? -

AFAIK the problem is that it has no default promotion for constants to 
long long (normally they are int, long, unsigned long etc. depending on
their value) It's some C99 thing. Or maybe a gcc bug. Anyways ULL 
makes it clear that it is unsigned long long.

-Andi

P.S.: The warning is thankfully turned off by default again in later
compilers.
