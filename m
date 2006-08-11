Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWHKKVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWHKKVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWHKKVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:21:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9372 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932065AbWHKKVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:21:11 -0400
Subject: Re: Upcall implementation in Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hsung-Pin Chang <hpchang@cs.nchu.edu.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060811041650.A0C2C3993@flute.cs.nchu.edu.tw>
References: <20060811041650.A0C2C3993@flute.cs.nchu.edu.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 11:41:19 +0100
Message-Id: <1155292879.24077.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 12:13 +0800, ysgrifennodd Hsung-Pin Chang:
>                 Dear all,
> 
>                 Recently, I need to use upcalls in Linux to actively and
> promptly inform 
>                 the user applications once an kernel event is occurred.
>                 However, I have some questions about upcall implementation.
>                 First, the user handler must be "pinned" into memory to
> prevent paging out.

Linux intentionally and deliberately does not support kernel calls into
user space. It leads to very difficult locking problems amongst other
things.

Instead we either send asynchronous events (signal/netlink/..) or we
arrange that a system call returns when the event happens so the user
process resumes.

