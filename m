Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUG0TGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUG0TGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUG0TEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:04:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:4061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266568AbUG0TC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:02:57 -0400
Date: Tue, 27 Jul 2004 12:01:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-Id: <20040727120125.0ec751a3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407271006290.23985@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
	<20040727132638.7d26e825.ak@suse.de>
	<Pine.LNX.4.58.0407271006290.23985@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Tue, 27 Jul 2004, Andi Kleen wrote:
> 
>  > On Tue, 27 Jul 2004 05:29:10 -0400 (EDT)
>  > Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>  >
>  > > This is a follow up to the previous patches for ia64 and i386, it will
>  > > allow x86_64 to reenable interrupts during contested locks depending on
>  > > previous interrupt enable status. It has been runtime and compile tested
>  > > on UP and 2x SMP Linux-tiny/x86_64.
>  >
>  > This will likely increase code size. Do you have numbers by how much? And is it
>  > really worth it?
> 
>  Yes there is a growth;
> 
>     text    data     bss     dec     hex filename
>  3655358 1340511  486128 5481997  53a60d vmlinux-after
>  3648445 1340511  486128 5475084  538b0c vmlinux-before

The growth is all in the out-of-line section, so there should be no
significant additional icache pressure.

