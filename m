Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263749AbTCVTUR>; Sat, 22 Mar 2003 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263762AbTCVTUQ>; Sat, 22 Mar 2003 14:20:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23707
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263749AbTCVTUP>; Sat, 22 Mar 2003 14:20:15 -0500
Subject: Re: [PATCH] reduce stack in cdrom/optcd.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, leo@netlabs.net
In-Reply-To: <3E7C0808.75B95FB7@verizon.net>
References: <3E7C0808.75B95FB7@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048365798.9221.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 20:43:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
> Hi,
> 
> This reduces stack usage in drivers/cdrom/optcd.c by
> dynamically allocating a large (> 2 KB) buffer.
> 
> Patch is to 2.5.65.  Please apply.

This loosk broken. You are using GFP_KERNEL memory allocations on the
read path of a block device. What happens if the allocation fails 
because we need memory

Surely that buffer needs to be allocated once at open and freed on close
?

