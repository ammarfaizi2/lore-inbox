Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTG3UHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTG3UHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:07:41 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:56821 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272223AbTG3UHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:07:40 -0400
Subject: Re: TSCs are a no-no on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730184529.GE21734@fs.tum.de>
References: <20030730135623.GA1873@lug-owl.de>
	 <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
	 <20030730184529.GE21734@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 21:01:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 19:45, Adrian Bunk wrote:
>   Note that this can also allow Step-A 486's to correctly run multi-thread
>   applications since cmpxchg has a wrong opcode on this early CPU.
> 
>   Don't use this to enable multi-threading on an SMP machine, the lock
>   atomicity can't be guaranted!

That is of course the other problem with this approach - you can't
really get the intended results without some extremely heavyweight code
(using an IPI to halt all CPU's, doing the access and then resuming
them)

The bigger problem (and certainly with some of the cmov emulation hacks
I've seen) is getting the security checking right when you need to
reprocess the user data - another reason to do it in userspace with a
preload 8)

