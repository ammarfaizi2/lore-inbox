Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVINIk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVINIk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVINIk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:40:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965090AbVINIk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:40:27 -0400
Date: Wed, 14 Sep 2005 01:39:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: joern@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was:
 Missing #include <config.h>)
Message-Id: <20050914013944.5ee4efa7.akpm@osdl.org>
In-Reply-To: <20050913155012.C23643@flint.arm.linux.org.uk>
References: <20050913135622.GA30675@phoenix.infradead.org>
	<20050913150825.A23643@flint.arm.linux.org.uk>
	<20050913155012.C23643@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>  LINUXINCLUDE    := -Iinclude \
>  -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
>  +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
>  +		   -imacros include/linux/autoconf.h

This means that over time the kernel will fail to compile correctly without
`-imacros include/linux/autoconf.h'.

That's OK for the kernel, but not for out-of-tree stuff.  Those drivers
will need to add the new gcc commandline option too.

Not that I'm saying it's a terrible thing.  It's just a thing.
