Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbULNUb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbULNUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbULNUb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:31:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:7319 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbULNUbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:31:25 -0500
Date: Tue, 14 Dec 2004 12:31:24 -0800
From: Chris Wright <chrisw@osdl.org>
To: ramos_fabiano@yahoo.com.br
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: help with access_process_vm
Message-ID: <20041214123124.R469@build.pdx.osdl.net>
References: <5afb2c65041214112577ff4a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5afb2c65041214112577ff4a18@mail.gmail.com>; from fabiano.ramos@gmail.com on Tue, Dec 14, 2004 at 05:25:23PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabiano Ramos (fabiano.ramos@gmail.com) wrote:
> But the first time a call access_process_vm, dmesg shows me:
>      
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
>  [<c01145ac>] __might_sleep+0x8c/0xa0
>  [<c011c69b>] access_process_vm+0x4b/0x1d0
>  [<c010c830>] do_debug_new+0xd0/0x190
>  [<c038c755>] schedule+0x275/0x460
>  [<c0105c2d>] error_code+0x2d/0x40
> 
> What I am missing?

The access_process_vm() call is doing down_read(), which could sleep,
with irqs disabled.  That's what's wrong.

thanks,
-chris
