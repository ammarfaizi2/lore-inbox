Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUH1UWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUH1UWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUH1UUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:20:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11136 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268015AbUH1US2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:18:28 -0400
Subject: Re: [PATCH] 2.6.8.1 MegaRAID Driver Race
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "bradgoodman.com" <bkgoodman@bradgoodman.com>
Cc: akpm@zip.com.au, Atul.Mukker@lsil.com, bgoodman@acopia.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, torvalds@osdl.org
In-Reply-To: <200408232157.i7NLvmB30968@bradgoodman.com>
References: <200408232157.i7NLvmB30968@bradgoodman.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093354017.2810.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 22:57, bradgoodman.com wrote:
> [PATCH] 2.6.8.1 to LSI Logic MegaRAID Adapter - ioctl function calls 
> mega_internal_command, which uses wait_event, which calls schedule.
> This means schedule() is called while big kernel_lock is held.

This is allowed. The bkl is dropped and regained across sleeps. Its a
lock that gives "traditional unix semantics" not a normal lock.

